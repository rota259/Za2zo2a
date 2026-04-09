import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_state.dart';
import 'map_marker_icon.dart';

class MapCanvas extends StatelessWidget {
  final MapLocationLoaded state;
  final MapController mapController;
  final VoidCallback onMapTap;
  final void Function(MapPosition position, bool hasGesture) onPositionChanged;

  const MapCanvas({
    super.key,
    required this.state,
    required this.mapController,
    required this.onMapTap,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: state.userLocation,
        initialZoom: MapConstants.initialZoom,
        minZoom: MapConstants.minZoom,
        maxZoom: MapConstants.maxZoom,
        onTap: (tapPosition, point) => onMapTap(),
        onPositionChanged: onPositionChanged,
      ),
      children: [
        TileLayer(
          urlTemplate: MapConstants.googleTileUrl,
          subdomains: MapConstants.googleTileSubdomains,
          userAgentPackageName: MapConstants.userAgentPackageName,
        ),
        if (state.routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: state.routePoints,
                strokeWidth: 5,
                color: AppColors.info,
                borderStrokeWidth: 3,
                borderColor: Colors.white.withValues(alpha: 0.9),
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            Marker(
              point: state.userLocation,
              width: 70,
              height: 70,
              child: const IgnorePointer(child: MapUserLocationMarker()),
            ),
            if (state.destination != null)
              Marker(
                point: state.destination!,
                width: 56,
                height: 72,
                child: const IgnorePointer(child: MapDestinationMarker()),
              ),
          ],
        ),
      ],
    );
  }
}
