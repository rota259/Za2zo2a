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
