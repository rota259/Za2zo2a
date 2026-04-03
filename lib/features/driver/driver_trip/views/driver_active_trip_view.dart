import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/services/location_service.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';

import 'widgets/driver_active_trip_app_bar.dart';
import 'widgets/driver_active_trip_next_turn.dart';
import 'widgets/driver_active_trip_controls.dart';
import 'widgets/driver_active_trip_sheet.dart';

class DriverActiveTripView extends StatefulWidget {
  const DriverActiveTripView({super.key});

  @override
  State<DriverActiveTripView> createState() => _DriverActiveTripViewState();
}

class _DriverActiveTripViewState extends State<DriverActiveTripView> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = const LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      _mapController.move(_currentLocation, 16.0);
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverTripCubit, DriverTripState>(
      listener: (context, state) {
        if (state is DriverTripCompleted) {
          context.pushReplacement('/driver/trip-summary');
        }
        if (state is DriverTripInitial) {
          context.go('/driver/home');
        }
      },
      builder: (context, state) {
        final bool isHeadingToPickup = state is DriverHeadingToPickup;

        return Scaffold(
          backgroundColor: const Color(0xFF1C2B39),
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentLocation,
                  initialZoom: 16.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.flutter_tasks_mostafa',
                  ),
                ],
              ),
              const DriverActiveTripAppBar(),
              const DriverActiveTripNextTurn(),
              DriverActiveTripControls(onLocationPressed: _getUserLocation),
              DriverActiveTripSheet(isHeadingToPickup: isHeadingToPickup),
            ],
          ),
        );
      },
    );
  }
}
