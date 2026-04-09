import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/route_model.dart';
import '../../data/models/search_result_model.dart';
import '../../domain/usecases/get_user_location_use_case.dart';
import '../../map_constants.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetUserLocationUseCase _getUserLocationUseCase;
  final http.Client _httpClient;
  final bool _ownsHttpClient;
  final StreamController<LatLng> _cameraMoveController =
      StreamController<LatLng>.broadcast();
  final Distance _distance = const Distance();

  StreamSubscription<LatLng>? _locationSubscription;
  MapLocationLoaded? _lastLoadedState;
  List<SearchResultModel> _searchResults = const [];
  SearchResultModel? _selectedDestinationResult;
  LocationFailureType? _lastLocationFailureType;
  DateTime? _lastRouteRefreshAt;
  bool _isRouteFetching = false;

  MapCubit({
    required GetUserLocationUseCase getUserLocationUseCase,
    http.Client? httpClient,
  }) : _getUserLocationUseCase = getUserLocationUseCase,
       _httpClient = httpClient ?? http.Client(),
       _ownsHttpClient = httpClient == null,
       super(const MapInitial());

  Stream<LatLng> get cameraMoveStream => _cameraMoveController.stream;
  MapLocationLoaded? get lastLoadedState => _lastLoadedState;
  List<SearchResultModel> get searchResults =>
      List.unmodifiable(_searchResults);
  SearchResultModel? get selectedDestinationResult =>
      _selectedDestinationResult;
  LocationFailureType? get lastLocationFailureType => _lastLocationFailureType;
  bool get isRouteFetching => _isRouteFetching;

  Future<void> initMap() => initLocation();

  Future<void> initLocation() async {
    emit(const MapLocationLoading());

    try {
      final userLocation = await _getUserLocationUseCase();
      final loadedState = MapLocationLoaded(
        userLocation: userLocation,
        destination: null,
        routePoints: const [],
        distanceText: null,
        durationText: null,
        isTripActive: false,
        isFollowingUser: true,
      );

      _lastLocationFailureType = null;
      _lastLoadedState = loadedState;
      emit(loadedState);
      moveToLocation(userLocation);
      await startLocationStream();
    } catch (error) {
      _emitError(_resolveErrorMessage(error), error: error);
    }
  }

  Future<void> startLocationStream() async {
    await stopLocationStream();

    try {
      _locationSubscription = _getUserLocationUseCase.locationStream().listen(
        _handleLiveLocationUpdate,
        onError: (Object error, StackTrace stackTrace) {
          _emitError(_resolveErrorMessage(error), error: error);
        },
      );
    } catch (error) {
      _emitError(_resolveErrorMessage(error), error: error);
    }
  }

  Future<void> stopLocationStream() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  Future<List<SearchResultModel>> searchPlaces(String query) async {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) {
      clearSearchResults();
      return const [];
    }

    emit(const MapSearching());

    try {
      final uri =
          Uri.https(MapConstants.nominatimHost, MapConstants.nominatimPath, {
            'q': normalizedQuery,
            'format': 'json',
            'limit': '${MapConstants.searchResultLimit}',
          });

      final response = await _httpClient
          .get(
            uri,
            headers: const {
              'Accept': 'application/json',
              'User-Agent': MapConstants.nominatimUserAgent,
            },
          )
          .timeout(MapConstants.apiTimeout);

      if (response.statusCode != 200) {
        throw const _MapApiException(MapConstants.searchUnavailableMessage);
      }

      final decodedBody = jsonDecode(response.body);
      if (decodedBody is! List) {
        throw const FormatException('Invalid search payload');
      }

      _searchResults = decodedBody
          .whereType<Map<String, dynamic>>()
          .map(SearchResultModel.fromJson)
          .where((result) => result.displayName.trim().isNotEmpty)
          .take(MapConstants.searchResultLimit)
          .toList(growable: false);

      _lastLocationFailureType = null;
      emit(MapSearchResults(_searchResults));
      return _searchResults;
    } catch (_) {
      _searchResults = const [];
      emit(const MapSearchResults([]));
      _emitNonLocationError(MapConstants.searchUnavailableMessage);
      return _searchResults;
    }
  }

  Future<void> selectDestination(SearchResultModel place) async {
    final currentState = _lastLoadedState;
    if (currentState == null) {
      return;
    }

    _selectedDestinationResult = place;
    _searchResults = const [];
    final updatedState = currentState.copyWith(
      destination: place.coordinates,
      routePoints: const [],
      distanceText: null,
      durationText: null,
      isFollowingUser: false,
    );

    _lastLoadedState = updatedState;
    emit(updatedState);
    await fetchRoute(updatedState.userLocation, place.coordinates);
  }

  Future<void> fetchRoute(LatLng origin, LatLng destination) async {
    if (_isRouteFetching) {
      return;
    }

    _isRouteFetching = true;
    emit(const MapRouteFetching());

    try {
      final uri = Uri.parse(
        '${MapConstants.osrmRouteBaseUrl}/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=geojson',
      );
      final response = await _httpClient
          .get(
            uri,
            headers: const {
              'Accept': 'application/json',
              'User-Agent': MapConstants.userAgentPackageName,
            },
          )
          .timeout(MapConstants.apiTimeout);

      if (response.statusCode != 200) {
        throw const _MapApiException(MapConstants.routeUnavailableMessage);
      }

      final decodedBody = jsonDecode(response.body);
      if (decodedBody is! Map<String, dynamic>) {
        throw const FormatException('Invalid route payload');
      }

      final route = RouteModel.fromOsrm(decodedBody);
      _lastRouteRefreshAt = DateTime.now();

      final currentState = _lastLoadedState;
      if (currentState == null) {
        return;
      }

      final updatedState = currentState.copyWith(
        destination: destination,
        routePoints: route.points,
        distanceText: _formatDistance(route.distanceMeters),
        durationText: _formatDuration(route.durationSeconds),
      );

      _lastLocationFailureType = null;
      _lastLoadedState = updatedState;
      emit(updatedState);
    } catch (_) {
      final currentState = _lastLoadedState;
      if (currentState != null) {
        final updatedState = currentState.copyWith(
          routePoints: const [],
          distanceText: null,
          durationText: null,
        );
        _lastLoadedState = updatedState;
        emit(updatedState);
      }

      _emitNonLocationError(MapConstants.routeUnavailableMessage);
    } finally {
      _isRouteFetching = false;
    }
  }

  void startTrip() {
    final currentState = _lastLoadedState;
    if (currentState == null) {
      return;
    }

    if (currentState.destination == null) {
      _emitNonLocationError(MapConstants.noDestinationSelectedMessage);
      return;
    }

    final updatedState = currentState.copyWith(isTripActive: true);
    _lastLoadedState = updatedState;
    emit(updatedState);
  }

  void endTrip() {
    final currentState = _lastLoadedState;
    if (currentState == null) {
      return;
    }

    _selectedDestinationResult = null;
    _searchResults = const [];
    final updatedState = currentState.copyWith(
      destination: null,
      routePoints: const [],
      distanceText: null,
      durationText: null,
      isTripActive: false,
      isFollowingUser: true,
    );

    _lastLoadedState = updatedState;
    emit(updatedState);
    moveToLocation(updatedState.userLocation);
  }

  Future<void> navigateWithGoogleMaps() async {
    final destination = _lastLoadedState?.destination;
    if (destination == null) {
      _emitNonLocationError(MapConstants.noDestinationSelectedMessage);
      return;
    }

    final googleNavigationUri = Uri.parse(
      'google.navigation:q=${destination.latitude},${destination.longitude}&mode=d',
    );
    final fallbackUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}&travelmode=driving',
    );

    try {
      final launchedGoogleMaps = await launchUrl(
        googleNavigationUri,
        mode: LaunchMode.externalApplication,
      );

      if (launchedGoogleMaps) {
        return;
      }

      final launchedFallback = await launchUrl(
        fallbackUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launchedFallback) {
        _emitNonLocationError(MapConstants.navigationUnavailableMessage);
      }
    } catch (_) {
      _emitNonLocationError(MapConstants.navigationUnavailableMessage);
    }
  }

  void toggleFollowUser() {
    final currentState = _lastLoadedState;
    if (currentState == null) {
      return;
    }

    final updatedState = currentState.copyWith(
      isFollowingUser: !currentState.isFollowingUser,
    );
    _lastLoadedState = updatedState;
    emit(updatedState);

    if (updatedState.isFollowingUser) {
      moveToLocation(updatedState.userLocation);
    }
  }

  void moveToLocation(LatLng target) {
    _cameraMoveController.add(target);
  }

  void clearSearchResults() {
    _searchResults = const [];

    if (state is MapSearching || state is MapSearchResults) {
      emit(const MapSearchResults([]));
    }
  }

  String _resolveErrorMessage(Object error) {
    if (error is LocationAccessException) {
      return error.message;
    }

    return MapConstants.unexpectedLocationErrorMessage;
  }

  Future<void> _handleLiveLocationUpdate(LatLng userLocation) async {
    final currentState = _lastLoadedState;
    if (currentState == null) {
      final loadedState = MapLocationLoaded(
        userLocation: userLocation,
        destination: null,
        routePoints: const [],
        distanceText: null,
        durationText: null,
        isTripActive: false,
        isFollowingUser: true,
      );

      _lastLoadedState = loadedState;
      emit(loadedState);
      moveToLocation(userLocation);
      return;
    }

    final updatedState = currentState.copyWith(userLocation: userLocation);
    _lastLoadedState = updatedState;
    emit(updatedState);

    if (updatedState.isFollowingUser) {
      moveToLocation(userLocation);
    }

    await _refreshRouteIfNeeded(updatedState);
  }

  Future<void> _refreshRouteIfNeeded(MapLocationLoaded state) async {
    final destination = state.destination;
    if (destination == null || _isRouteFetching) {
      return;
    }

    if (state.routePoints.isEmpty) {
      await fetchRoute(state.userLocation, destination);
      return;
    }

    final minimumDistanceToRoute = state.routePoints
        .map(
          (point) => _distance.as(LengthUnit.Meter, state.userLocation, point),
        )
        .reduce((value, element) => value < element ? value : element);

    final canRefreshRoute =
        _lastRouteRefreshAt == null ||
        DateTime.now().difference(_lastRouteRefreshAt!) >=
            MapConstants.routeRefreshCooldown;

    if (minimumDistanceToRoute > MapConstants.routeRefreshThresholdMeters &&
        canRefreshRoute) {
      await fetchRoute(state.userLocation, destination);
    }
  }

  String _formatDistance(double distanceMeters) {
    if (distanceMeters >= 1000) {
      return '${(distanceMeters / 1000).toStringAsFixed(distanceMeters >= 10000 ? 0 : 1)} km';
    }

    return '${distanceMeters.round()} m';
  }

  String _formatDuration(int durationSeconds) {
    final totalMinutes = (durationSeconds / 60).ceil();
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours == 0) {
      return '$totalMinutes min';
    }

    if (minutes == 0) {
      return '$hours h';
    }

    return '$hours h $minutes min';
  }

  void _emitError(String message, {Object? error}) {
    _lastLocationFailureType = error is LocationAccessException
        ? error.type
        : null;
    emit(MapError(message));
  }

  void _emitNonLocationError(String message) {
    _lastLocationFailureType = null;
    emit(MapError(message));
  }

  @override
  Future<void> close() async {
    await stopLocationStream();
    if (_ownsHttpClient) {
      _httpClient.close();
    }
    await _cameraMoveController.close();
    return super.close();
  }
}

class _MapApiException implements Exception {
  final String message;

  const _MapApiException(this.message);

  @override
  String toString() => message;
}
