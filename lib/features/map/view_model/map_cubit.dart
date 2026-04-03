import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/services/location_service.dart';
import '../model/route_model.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final Dio _dio = Dio();
  Timer? _mockDriverTimer;

  // OSRM Public API URL
  static const String _osrmBaseUrl =
      'https://router.project-osrm.org/route/v1/driving';

  MapCubit() : super(MapInitial());

  /// Fetch initial user location
  Future<void> fetchUserLocation() async {
    emit(const MapLoading('Getting your location...'));
    try {
      final position = await LocationService.getCurrentLocation();
      emit(
        MapReady(userLocation: LatLng(position.latitude, position.longitude)),
      );
    } catch (e) {
      emit(MapError('Failed to get location: $e'));
    }
  }

  /// Drop a destination marker and fetch a route automatically
  Future<void> setDestinationAndFetchRoute(LatLng destination) async {
    final currentState = state;
    if (currentState is MapReady) {
      emit(const MapLoading('Calculating route...'));
      try {
        final origin = currentState.userLocation;
        // OSRM format: longitude,latitude
        final url =
            '$_osrmBaseUrl/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?geometries=geojson&overview=full';

        final response = await _dio.get(url);
        if (response.statusCode == 200) {
          final route = RouteModel.fromJson(response.data);
          emit(
            MapReady(
              userLocation: currentState.userLocation,
              destination: destination,
              route: route,
            ),
          );
        } else {
          emit(
            MapError('Failed to calculate route. code: ${response.statusCode}'),
          );
          emit(currentState); // fallback
        }
      } catch (e) {
        emit(MapError('Routing error: $e'));
        emit(currentState);
      }
    }
  }

  /// Simulate driver movement along the fetched route points
  void simulateDriverMovement() {
    final currentState = state;
    if (currentState is MapReady && currentState.route != null) {
      final points = currentState.route!.polylinePoints;
      if (points.isEmpty) return;

      int curIndex = 0;
      _mockDriverTimer?.cancel();
      _mockDriverTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (curIndex >= points.length) {
          timer.cancel();
          return;
        }

        final liveState = state;
        if (liveState is MapReady) {
          emit(liveState.copyWith(driverMockLocation: points[curIndex]));
        }

        // Skip ahead to simulate decent speed (depends on polyline density)
        curIndex += 3;
      });
    }
  }

  void cancelSimulation() {
    _mockDriverTimer?.cancel();
    final currentState = state;
    if (currentState is MapReady) {
      // Clear driver mock
      emit(
        MapReady(
          userLocation: currentState.userLocation,
          destination: currentState.destination,
          route: currentState.route,
          driverMockLocation: null,
        ),
      );
    }
  }

  void clearDestination() {
    final currentState = state;
    if (currentState is MapReady) {
      emit(currentState.copyWith(clearDestination: true));
    }
  }

  @override
  Future<void> close() {
    _mockDriverTimer?.cancel();
    return super.close();
  }
}
