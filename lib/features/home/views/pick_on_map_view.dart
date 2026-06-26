import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/location_service.dart';

class PickOnMapView extends StatefulWidget {
  const PickOnMapView({super.key});

  @override
  State<PickOnMapView> createState() => _PickOnMapViewState();
}

class _PickOnMapViewState extends State<PickOnMapView> {
  final _mapController = MapController();
  LatLng _center = const LatLng(30.0444, 31.2357); // Cairo default
  LatLng? _picked;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    try {
      final pos = await LocationService.getCurrentLocation();
      if (!mounted) return;
      final here = LatLng(pos.latitude, pos.longitude);
      setState(() => _center = here);
      _mapController.move(here, AppConstants.initialMapZoom);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick destination'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: AppConstants.initialMapZoom,
              minZoom: AppConstants.minZoom,
              maxZoom: AppConstants.maxZoom,
              onTap: (tapPos, point) {
                setState(() => _picked = point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.osmTileUrl,
                userAgentPackageName: AppConstants.tileUserAgentPackageName,
              ),
              if (_picked != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _picked!,
                      width: 44,
                      height: 44,
                      child:
                          Icon(Icons.location_on, color: AppColors.primary, size: 40),
                    ),
                  ],
                ),
            ],
          ),
          // Center crosshair hint (before pick)
          if (_picked == null)
            const Center(
              child: Icon(Icons.add, size: 32, color: Colors.black38),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _picked != null ? () => context.pop(_picked) : null,
            child: Text(
              _picked != null ? 'Confirm location' : 'Tap on the map to pick',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
