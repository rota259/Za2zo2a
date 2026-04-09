import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class HomeMapWidget extends StatelessWidget {
  final MapController mapController;
  final LatLng userLocation;
  final LatLng? selectedLocation;

  const HomeMapWidget({
    super.key,
    required this.mapController,
    required this.userLocation,
    required this.selectedLocation,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: userLocation,
        initialZoom: AppConstants.initialMapZoom,
        minZoom: AppConstants.minZoom,
        maxZoom: AppConstants.maxZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: AppConstants.osmTileUrl,
          userAgentPackageName: AppConstants.tileUserAgentPackageName,
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: userLocation,
              width: 52,
              height: 52,
              child: Icon(
                Icons.my_location,
                color: AppColors.primary,
                size: 34,
              ),
            ),
            if (selectedLocation != null)
              Marker(
                point: selectedLocation!,
                width: 52,
                height: 52,
                child: Icon(
                  Icons.location_on,
                  color: AppColors.darkRed,
                  size: 38,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
