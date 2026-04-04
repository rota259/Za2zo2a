import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'dart:math' as math;
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  Future<void> initMap() async {
    emit(MapLoading());
    try {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        emit(const MapError('Location permissions are denied'));
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final LatLng currentLocation = LatLng(position.latitude, position.longitude);

      emit(MapLoaded(
        currentLocation: currentLocation,
        pickupLocation: currentLocation, // default
      ));
    } catch (e) {
      emit(MapError(e.toString()));
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final locationPlugin = loc.Location();
      serviceEnabled = await locationPlugin.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void updatePickupLocation(LatLng location) {
    if (state is MapLoaded) {
      emit((state as MapLoaded).copyWith(pickupLocation: location));
    }
  }

  void setDestination(LatLng destination) {
    if (state is MapLoaded) {
      emit((state as MapLoaded).copyWith(destinationLocation: destination));
    }
  }

  void findDriver() async {
    if (state is MapLoaded) {
      final loadedState = state as MapLoaded;
      emit(loadedState.copyWith(isFindingDriver: true, driverFound: false));

      // Simulate network call
      await Future.delayed(const Duration(seconds: 3));

      // Generate a mock driver location nearby the pickup location
      final random = math.Random();
      final latOffset = (random.nextDouble() - 0.5) * 0.01;
      final lngOffset = (random.nextDouble() - 0.5) * 0.01;
      
      final mockDriverLocation = LatLng(
        loadedState.pickupLocation.latitude + latOffset,
        loadedState.pickupLocation.longitude + lngOffset,
      );

      emit((state as MapLoaded).copyWith(
        isFindingDriver: false,
        driverFound: true,
        driverLocation: mockDriverLocation,
      ));
    }
  }

  void resetRide() {
    if (state is MapLoaded) {
      final loadedState = state as MapLoaded;
      emit(MapLoaded(
        currentLocation: loadedState.currentLocation,
        pickupLocation: loadedState.currentLocation,
      ));
    }
  }
}
