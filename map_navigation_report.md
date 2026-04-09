# Map Navigation Feature Report

Verification:
- `flutter pub get` succeeded.
- `flutter analyze` succeeded with zero issues.
- `flutter test` passed.
- `flutter build apk --debug` succeeded.

Key files updated for this feature:
- `lib/features/map/presentation/viewmodel/map_cubit.dart`
- `lib/features/map/presentation/viewmodel/map_state.dart`
- `lib/features/map/presentation/view/map_view.dart`
- `lib/features/map/presentation/view/widgets/map_view_content.dart`
- `lib/features/map/data/models/search_result_model.dart`
- `lib/features/map/data/models/route_model.dart`
- `lib/features/map/domain/usecases/get_user_location_use_case.dart`
- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`

## `lib/features/map/presentation/viewmodel/map_cubit.dart`

```dart
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
```

## `lib/features/map/presentation/viewmodel/map_state.dart`

```dart
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/search_result_model.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

final class MapInitial extends MapState {
  const MapInitial();
}

final class MapLocationLoading extends MapState {
  const MapLocationLoading();
}

final class MapLocationLoaded extends MapState {
  final LatLng userLocation;
  final LatLng? destination;
  final List<LatLng> routePoints;
  final String? distanceText;
  final String? durationText;
  final bool isTripActive;
  final bool isFollowingUser;

  const MapLocationLoaded({
    required this.userLocation,
    required this.destination,
    required this.routePoints,
    required this.distanceText,
    required this.durationText,
    required this.isTripActive,
    required this.isFollowingUser,
  });

  static const Object _unset = Object();

  MapLocationLoaded copyWith({
    LatLng? userLocation,
    Object? destination = _unset,
    List<LatLng>? routePoints,
    Object? distanceText = _unset,
    Object? durationText = _unset,
    bool? isTripActive,
    bool? isFollowingUser,
  }) {
    return MapLocationLoaded(
      userLocation: userLocation ?? this.userLocation,
      destination: identical(destination, _unset)
          ? this.destination
          : destination as LatLng?,
      routePoints: routePoints ?? this.routePoints,
      distanceText: identical(distanceText, _unset)
          ? this.distanceText
          : distanceText as String?,
      durationText: identical(durationText, _unset)
          ? this.durationText
          : durationText as String?,
      isTripActive: isTripActive ?? this.isTripActive,
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    );
  }

  @override
  List<Object?> get props => [
    userLocation,
    destination,
    routePoints,
    distanceText,
    durationText,
    isTripActive,
    isFollowingUser,
  ];
}

final class MapSearching extends MapState {
  const MapSearching();
}

final class MapSearchResults extends MapState {
  final List<SearchResultModel> results;

  const MapSearchResults(this.results);

  @override
  List<Object?> get props => [results];
}

final class MapRouteFetching extends MapState {
  const MapRouteFetching();
}

final class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object?> get props => [message];
}
```

## `lib/features/map/presentation/view/map_view.dart`

```dart
import 'package:flutter/material.dart';
import 'widgets/map_view_content.dart';

class MapView extends StatelessWidget {
  final bool showScaffold;
  final bool showSearchBar;
  final bool showLocationDetails;
  final bool showMapControls;
  final bool allowMarkerCreation;

  const MapView({
    super.key,
    this.showScaffold = true,
    this.showSearchBar = true,
    this.showLocationDetails = true,
    this.showMapControls = true,
    this.allowMarkerCreation = true,
  });

  const MapView.embedded({
    super.key,
    this.showScaffold = false,
    this.showSearchBar = false,
    this.showLocationDetails = false,
    this.showMapControls = false,
    this.allowMarkerCreation = false,
  });

  @override
  Widget build(BuildContext context) {
    return MapViewContent(
      showScaffold: showScaffold,
      showSearchBar: showSearchBar,
      showLocationDetails: showLocationDetails,
      showMapControls: showMapControls,
      allowMarkerCreation: allowMarkerCreation,
    );
  }
}
```

## `lib/features/map/presentation/view/widgets/map_view_content.dart`

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../data/models/search_result_model.dart';
import '../../../domain/usecases/get_user_location_use_case.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_cubit.dart';
import '../../viewmodel/map_state.dart';
import 'map_empty_state.dart';
import 'map_interactive_pane.dart';
import 'map_loading_overlay.dart';
import 'map_mobile_layout.dart';
import 'map_tablet_layout.dart';

class MapViewContent extends StatefulWidget {
  final bool showScaffold;
  final bool showSearchBar;
  final bool showLocationDetails;
  final bool showMapControls;
  final bool allowMarkerCreation;

  const MapViewContent({
    super.key,
    required this.showScaffold,
    required this.showSearchBar,
    required this.showLocationDetails,
    required this.showMapControls,
    required this.allowMarkerCreation,
  });

  @override
  State<MapViewContent> createState() => _MapViewContentState();
}

class _MapViewContentState extends State<MapViewContent> {
  late final MapController _mapController;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  StreamSubscription<dynamic>? _cameraMoveSubscription;
  LatLng? _currentCenter;
  double _currentZoom = MapConstants.initialZoom;
  String? _lastFittedDestinationKey;
  bool _isShowingDialog = false;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    _cameraMoveSubscription = context.read<MapCubit>().cameraMoveStream.listen((
      target,
    ) {
      if (!mounted) {
        return;
      }

      _currentCenter = target;
      _mapController.move(target, _currentZoom);
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _cameraMoveSubscription?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleMapTap() {
    _searchFocusNode.unfocus();
    context.read<MapCubit>().clearSearchResults();
    setState(() {});
  }

  void _handleSearchChanged(String value) {
    _searchDebounce?.cancel();

    if (value.trim().isEmpty) {
      context.read<MapCubit>().clearSearchResults();
      setState(() {});
      return;
    }

    _searchDebounce = Timer(MapConstants.searchDebounce, () {
      if (!mounted) {
        return;
      }

      context.read<MapCubit>().searchPlaces(value);
    });
  }

  void _handleSearchCleared() {
    _searchDebounce?.cancel();
    _searchController.clear();
    context.read<MapCubit>().clearSearchResults();
    setState(() {});
  }

  Future<void> _handleSuggestionSelected(SearchResultModel result) async {
    _searchController.text = result.title;
    _searchFocusNode.unfocus();
    setState(() {});
    await context.read<MapCubit>().selectDestination(result);
  }

  void _handleCenterOnUser(MapLocationLoaded state) {
    final cubit = context.read<MapCubit>();
    if (!state.isFollowingUser) {
      cubit.toggleFollowUser();
    }
    cubit.moveToLocation(state.userLocation);
  }

  void _handleTripAction(MapLocationLoaded state) {
    final cubit = context.read<MapCubit>();
    if (state.isTripActive) {
      _searchController.clear();
      cubit.endTrip();
      setState(() {});
      return;
    }

    cubit.startTrip();
  }

  void _handlePositionChanged(MapPosition position, bool hasGesture) {
    _currentCenter = position.center ?? _currentCenter;
    _currentZoom = position.zoom ?? _currentZoom;

    final cubit = context.read<MapCubit>();
    final loadedState = cubit.lastLoadedState;
    if (hasGesture && (loadedState?.isFollowingUser ?? false)) {
      cubit.toggleFollowUser();
    }
  }

  void _handleZoom(double delta) {
    if (_currentCenter == null) {
      return;
    }

    final nextZoom = (_currentZoom + delta).clamp(
      MapConstants.minZoom,
      MapConstants.maxZoom,
    );

    _currentZoom = nextZoom;
    _mapController.move(_currentCenter!, nextZoom);
  }

  void _maybeFitCamera(MapLocationLoaded state) {
    final destination = state.destination;
    if (destination == null) {
      _lastFittedDestinationKey = null;
      return;
    }

    final routeSignature =
        '${destination.latitude.toStringAsFixed(6)}_${destination.longitude.toStringAsFixed(6)}_${state.routePoints.length}';
    if (_lastFittedDestinationKey == routeSignature) {
      return;
    }

    _lastFittedDestinationKey = routeSignature;
    final coordinates = state.routePoints.isNotEmpty
        ? state.routePoints
        : [state.userLocation, destination];
    final rightPadding = context.isTablet && widget.showLocationDetails
        ? MapConstants.tabletPanelWidth
        : 32.0;
    final bottomPadding = context.isMobile && widget.showLocationDetails
        ? MapConstants.mobileMapBottomInset
        : 32.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || coordinates.isEmpty) {
        return;
      }

      _mapController.fitCamera(
        CameraFit.coordinates(
          coordinates: coordinates,
          padding: EdgeInsets.fromLTRB(
            32,
            widget.showSearchBar ? 140 : 32,
            rightPadding,
            bottomPadding,
          ),
          maxZoom: MapConstants.maxZoom,
        ),
      );
    });
  }

  Widget _wrapContent(Widget child) {
    if (!widget.showScaffold) {
      return child;
    }

    return Scaffold(body: child);
  }

  Future<void> _handleErrorState(BuildContext context, String message) async {
    final cubit = context.read<MapCubit>();
    final failureType = cubit.lastLocationFailureType;

    if (failureType == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.error),
        );
      return;
    }

    if (_isShowingDialog) {
      return;
    }

    _isShowingDialog = true;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(_resolveDialogTitle(failureType)),
          content: Text(_resolveDialogMessage(failureType)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(MapConstants.cancelLabel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                switch (failureType) {
                  case LocationFailureType.servicesDisabled:
                    await Geolocator.openLocationSettings();
                    break;
                  case LocationFailureType.permissionDenied:
                  case LocationFailureType.permissionDeniedForever:
                    await Geolocator.openAppSettings();
                    break;
                  case LocationFailureType.timeout:
                    if (mounted) {
                      await context.read<MapCubit>().initLocation();
                    }
                    break;
                }
              },
              child: Text(_resolveDialogActionLabel(failureType)),
            ),
          ],
        );
      },
    );
    _isShowingDialog = false;
  }

  String _resolveDialogTitle(LocationFailureType failureType) {
    switch (failureType) {
      case LocationFailureType.servicesDisabled:
        return MapConstants.gpsDialogTitle;
      case LocationFailureType.permissionDenied:
      case LocationFailureType.permissionDeniedForever:
        return MapConstants.permissionDialogTitle;
      case LocationFailureType.timeout:
        return MapConstants.timeoutDialogTitle;
    }
  }

  String _resolveDialogMessage(LocationFailureType failureType) {
    switch (failureType) {
      case LocationFailureType.servicesDisabled:
        return MapConstants.gpsDialogMessage;
      case LocationFailureType.permissionDenied:
      case LocationFailureType.permissionDeniedForever:
        return MapConstants.permissionDialogMessage;
      case LocationFailureType.timeout:
        return MapConstants.timeoutDialogMessage;
    }
  }

  String _resolveDialogActionLabel(LocationFailureType failureType) {
    switch (failureType) {
      case LocationFailureType.servicesDisabled:
        return MapConstants.enableGpsLabel;
      case LocationFailureType.permissionDenied:
      case LocationFailureType.permissionDeniedForever:
        return MapConstants.openSettingsLabel;
      case LocationFailureType.timeout:
        return MapConstants.retryLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapLocationLoaded) {
          _currentCenter = state.userLocation;
          _maybeFitCamera(state);
        }

        if (state is MapError) {
          _handleErrorState(context, state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<MapCubit>();
        final cachedState = cubit.lastLoadedState;
        final mapState = state is MapLocationLoaded ? state : cachedState;
        final searchResults = cubit.searchResults;
        final destinationDetails = cubit.selectedDestinationResult;
        final isSearching = state is MapSearching;
        final isRouteFetching =
            state is MapRouteFetching || cubit.isRouteFetching;

        if (state is MapError && mapState == null) {
          return _wrapContent(
            SafeArea(
              child: MapEmptyState(
                title: MapConstants.mapUnavailableTitle,
                description: state.message,
                onRetry: context.read<MapCubit>().initLocation,
              ),
            ),
          );
        }

        return _wrapContent(
          LayoutBuilder(
            builder: (context, constraints) {
              if (mapState == null) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: AppColors.grey100),
                    if (state is MapLocationLoading)
                      const MapLoadingOverlay(
                        message: MapConstants.locationLoadingMessage,
                      ),
                  ],
                );
              }

              final content = widget.showLocationDetails
                  ? context.isMobile
                        ? MapMobileLayout(
                            state: mapState,
                            mapController: _mapController,
                            showSearchBar: widget.showSearchBar,
                            showMapControls: widget.showMapControls,
                            searchController: _searchController,
                            searchFocusNode: _searchFocusNode,
                            searchResults: searchResults,
                            destinationDetails: destinationDetails,
                            isSearching: isSearching,
                            isRouteFetching: isRouteFetching,
                            onMapTap: _handleMapTap,
                            onSearchChanged: _handleSearchChanged,
                            onSearchCleared: _handleSearchCleared,
                            onSuggestionSelected: _handleSuggestionSelected,
                            onNavigate: cubit.navigateWithGoogleMaps,
                            onPositionChanged: _handlePositionChanged,
                            onCenterOnUserLocation: () =>
                                _handleCenterOnUser(mapState),
                            onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                            onZoomOut: () =>
                                _handleZoom(-MapConstants.zoomStep),
                            onTripAction: () => _handleTripAction(mapState),
                          )
                        : MapTabletLayout(
                            state: mapState,
                            mapController: _mapController,
                            showSearchBar: widget.showSearchBar,
                            showMapControls: widget.showMapControls,
                            searchController: _searchController,
                            searchFocusNode: _searchFocusNode,
                            searchResults: searchResults,
                            destinationDetails: destinationDetails,
                            isSearching: isSearching,
                            isRouteFetching: isRouteFetching,
                            onMapTap: _handleMapTap,
                            onSearchChanged: _handleSearchChanged,
                            onSearchCleared: _handleSearchCleared,
                            onSuggestionSelected: _handleSuggestionSelected,
                            onNavigate: cubit.navigateWithGoogleMaps,
                            onPositionChanged: _handlePositionChanged,
                            onCenterOnUserLocation: () =>
                                _handleCenterOnUser(mapState),
                            onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                            onZoomOut: () =>
                                _handleZoom(-MapConstants.zoomStep),
                            onTripAction: () => _handleTripAction(mapState),
                          )
                  : MapInteractivePane(
                      state: mapState,
                      mapController: _mapController,
                      bottomInset: 16,
                      showSearchBar: widget.showSearchBar,
                      showMapControls: widget.showMapControls,
                      searchController: _searchController,
                      searchFocusNode: _searchFocusNode,
                      searchResults: searchResults,
                      isSearching: isSearching,
                      showNavigateButton: false,
                      onMapTap: _handleMapTap,
                      onSearchChanged: _handleSearchChanged,
                      onSearchCleared: _handleSearchCleared,
                      onSuggestionSelected: _handleSuggestionSelected,
                      onNavigate: cubit.navigateWithGoogleMaps,
                      onPositionChanged: _handlePositionChanged,
                      onCenterOnUserLocation: () =>
                          _handleCenterOnUser(mapState),
                      onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                      onZoomOut: () => _handleZoom(-MapConstants.zoomStep),
                    );

              return Stack(
                fit: StackFit.expand,
                children: [
                  content,
                  if (state is MapLocationLoading)
                    const MapLoadingOverlay(
                      message: MapConstants.locationLoadingMessage,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
```

## `lib/features/map/data/models/search_result_model.dart`

```dart
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class SearchResultModel extends Equatable {
  final String displayName;
  final double lat;
  final double lon;
  final String placeId;

  const SearchResultModel({
    required this.displayName,
    required this.lat,
    required this.lon,
    required this.placeId,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      displayName: (json['display_name'] ?? '') as String,
      lat: double.tryParse('${json['lat'] ?? ''}') ?? 0,
      lon: double.tryParse('${json['lon'] ?? ''}') ?? 0,
      placeId: '${json['place_id'] ?? ''}',
    );
  }

  LatLng get coordinates => LatLng(lat, lon);

  String get title {
    final separatorIndex = displayName.indexOf(',');
    if (separatorIndex == -1) {
      return displayName.trim();
    }

    return displayName.substring(0, separatorIndex).trim();
  }

  String get address {
    final separatorIndex = displayName.indexOf(',');
    if (separatorIndex == -1) {
      return displayName.trim();
    }

    return displayName.substring(separatorIndex + 1).trim();
  }

  @override
  List<Object?> get props => [displayName, lat, lon, placeId];
}
```

## `lib/features/map/data/models/route_model.dart`

```dart
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class RouteModel extends Equatable {
  final List<LatLng> points;
  final double distanceMeters;
  final int durationSeconds;

  const RouteModel({
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
  });

  factory RouteModel.fromOsrm(Map<String, dynamic> json) {
    final routes = json['routes'];
    if (routes is! List || routes.isEmpty) {
      throw const FormatException('No route found');
    }

    final route = routes.first;
    if (route is! Map<String, dynamic>) {
      throw const FormatException('Invalid route payload');
    }

    final geometry = route['geometry'];
    if (geometry is! Map<String, dynamic>) {
      throw const FormatException('Missing route geometry');
    }

    final coordinates = geometry['coordinates'];
    if (coordinates is! List || coordinates.isEmpty) {
      throw const FormatException('No route coordinates found');
    }

    final points = coordinates
        .map((coordinate) {
          if (coordinate is! List || coordinate.length < 2) {
            throw const FormatException('Invalid coordinate pair');
          }

          final lon = (coordinate[0] as num).toDouble();
          final lat = (coordinate[1] as num).toDouble();
          return LatLng(lat, lon);
        })
        .toList(growable: false);

    return RouteModel(
      points: points,
      distanceMeters: (route['distance'] as num?)?.toDouble() ?? 0,
      durationSeconds: ((route['duration'] as num?)?.toDouble() ?? 0).round(),
    );
  }

  @override
  List<Object?> get props => [points, distanceMeters, durationSeconds];
}
```

## `lib/features/map/domain/usecases/get_user_location_use_case.dart`

```dart
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../map_constants.dart';

class GetUserLocationUseCase {
  const GetUserLocationUseCase();

  Future<LatLng> call() async {
    await ensureLocationAccess();

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: MapConstants.locationTimeout,
      );

      return _toLatLng(position);
    } on TimeoutException {
      throw const LocationAccessException(
        MapConstants.locationTimeoutMessage,
        LocationFailureType.timeout,
      );
    } on LocationServiceDisabledException {
      throw const LocationAccessException(
        MapConstants.locationServicesDisabledMessage,
        LocationFailureType.servicesDisabled,
      );
    }
  }

  Stream<LatLng> locationStream() async* {
    await ensureLocationAccess();

    yield* Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
        timeLimit: MapConstants.locationTimeout,
      ),
    ).map(_toLatLng).handleError((Object error) {
      if (error is TimeoutException) {
        throw const LocationAccessException(
          MapConstants.locationTimeoutMessage,
          LocationFailureType.timeout,
        );
      }

      if (error is LocationServiceDisabledException) {
        throw const LocationAccessException(
          MapConstants.locationServicesDisabledMessage,
          LocationFailureType.servicesDisabled,
        );
      }

      throw error;
    });
  }

  Future<void> ensureLocationAccess() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw const LocationAccessException(
        MapConstants.locationServicesDisabledMessage,
        LocationFailureType.servicesDisabled,
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const LocationAccessException(
        MapConstants.permissionDeniedMessage,
        LocationFailureType.permissionDenied,
      );
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationAccessException(
        MapConstants.permissionDeniedForeverMessage,
        LocationFailureType.permissionDeniedForever,
      );
    }
  }

  LatLng _toLatLng(Position position) {
    return LatLng(position.latitude, position.longitude);
  }
}

enum LocationFailureType {
  servicesDisabled,
  permissionDenied,
  permissionDeniedForever,
  timeout,
}

class LocationAccessException implements Exception {
  final String message;
  final LocationFailureType type;

  const LocationAccessException(this.message, this.type);

  @override
  String toString() => message;
}
```

## `pubspec.yaml`

```yaml
name: za2zo2a
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: ^3.10.7

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.8.0
  firebase_auth: ^4.6.0
  provider: ^6.0.5
  flutter_svg: ^1.1.6   # لو في أي أيقونات SVG


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  flutter_bloc: ^8.1.3
  go_router: ^14.6.2
  dio: ^5.7.0
  google_fonts: ^6.2.1
  flutter_rating_bar: ^4.0.1
  smooth_page_indicator: ^1.1.0
  equatable: ^2.0.5
  flutter_screenutil: ^5.9.3
  font_awesome_flutter: ^11.0.0
  image_picker: ^1.2.1
  geolocator: ^10.1.0
  geocoding: ^4.0.0
  flutter_map: ^6.0.0
  latlong2: ^0.9.0
  cached_network_image: ^3.4.1
  url_launcher: ^6.2.5
  http: ^1.2.0
  flutter_typeahead: ^5.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^6.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_ham.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package
```

## `android/app/src/main/AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

    <application
        android:label="Za2zo2a"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <!-- Required to query activities that can process text, see:
         https://developer.android.com/training/package-visibility and
         https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.

         In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
```

## `ios/Runner/Info.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleDisplayName</key>
	<string>Za2zo2a</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>za2zo2a</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>CADisableMinimumFrameDurationOnPhone</key>
	<true/>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>We need your location to show your position on map</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>We need your location to track your trip</string>
</dict>
</plist>
```

