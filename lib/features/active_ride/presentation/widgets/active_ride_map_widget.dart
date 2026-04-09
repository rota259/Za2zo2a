import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/route_entity.dart';
import 'turn_instruction_card.dart';

class ActiveRideMapWidget extends StatefulWidget {
  final RouteEntity route;
  final String instruction;

  const ActiveRideMapWidget({
    super.key,
    required this.route,
    required this.instruction,
  });

  @override
  State<ActiveRideMapWidget> createState() => _ActiveRideMapWidgetState();
}

class _ActiveRideMapWidgetState extends State<ActiveRideMapWidget> {
  final _mapController = MapController();
  double _zoom = AppConstants.initialMapZoom;
  String? _signature;

  @override
  void didUpdateWidget(covariant ActiveRideMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _fitRoute();
  }

  void _fitRoute() {
    final signature =
        '${widget.route.origin}_${widget.route.destination}_${widget.route.points.length}';
    if (_signature == signature) {
      return;
    }
    _signature = signature;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _mapController.fitCamera(
        CameraFit.coordinates(
          coordinates: widget.route.points.isEmpty
              ? [widget.route.origin, widget.route.destination]
              : widget.route.points,
          padding: const EdgeInsets.fromLTRB(24, 96, 24, 96),
          maxZoom: AppConstants.maxZoom,
        ),
      );
    });
  }

  void _zoomBy(double delta) {
    final center = _mapController.camera.center;
    _zoom = (_zoom + delta).clamp(AppConstants.minZoom, AppConstants.maxZoom);
    _mapController.move(center, _zoom);
  }

  @override
  Widget build(BuildContext context) {
    _fitRoute();
    final points = widget.route.points.isEmpty
        ? [widget.route.origin, widget.route.destination]
        : widget.route.points;

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: widget.route.origin,
            initialZoom: AppConstants.initialMapZoom,
          ),
          children: [
            TileLayer(
              urlTemplate: AppConstants.osmTileUrl,
              userAgentPackageName: AppConstants.tileUserAgentPackageName,
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: points,
                  strokeWidth: 5,
                  color: AppColors.primary,
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: widget.route.origin,
                  width: 40,
                  height: 40,
                  child: Icon(Icons.location_history, color: AppColors.primary),
                ),
                Marker(
                  point: widget.route.destination,
                  width: 40,
                  height: 40,
                  child: Icon(Icons.flag_circle, color: AppColors.darkRed),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: TurnInstructionCard(instruction: widget.instruction),
        ),
        Positioned(
          right: 12,
          top: 110,
          child: Column(
            children: [
              FloatingActionButton.small(
                heroTag: 'ride_zoom_in',
                backgroundColor: AppColors.background,
                onPressed: () => _zoomBy(1),
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.small(
                heroTag: 'ride_zoom_out',
                backgroundColor: AppColors.background,
                onPressed: () => _zoomBy(-1),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
        Positioned(
          right: 12,
          bottom: 20,
          child: FloatingActionButton.small(
            heroTag: 'ride_center',
            backgroundColor: AppColors.primary,
            onPressed: _fitRoute,
            child: Icon(Icons.my_location, color: AppColors.background),
          ),
        ),
      ],
    );
  }
}
