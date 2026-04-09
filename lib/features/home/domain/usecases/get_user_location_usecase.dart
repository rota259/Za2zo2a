import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_strings.dart';

class GetUserLocationUsecase {
  const GetUserLocationUsecase();

  Future<LatLng> call() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationAccessException(
        AppStrings.locationServicesDisabled,
        true,
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw const LocationAccessException(
        AppStrings.locationPermissionDenied,
        true,
      );
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return LatLng(position.latitude, position.longitude);
  }
}

class LocationAccessException implements Exception {
  final String message;
  final bool shouldOpenSettings;

  const LocationAccessException(this.message, this.shouldOpenSettings);
}
