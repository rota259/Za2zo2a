import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/services/location_service.dart';
import '../cubit/ride_cubit.dart';
import '../cubit/ride_state.dart';

import 'widgets/active_trip_app_bar.dart';
import 'widgets/active_trip_next_turn.dart';
import 'widgets/active_trip_map_controls.dart';
import 'widgets/active_trip_details_sheet.dart';

class ActiveTripView extends StatefulWidget {
  const ActiveTripView({super.key});

  @override
  State<ActiveTripView> createState() => _ActiveTripViewState();
}

class _ActiveTripViewState extends State<ActiveTripView> {
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
      setState(
        () => _currentLocation = LatLng(position.latitude, position.longitude),
      );
      _mapController.move(_currentLocation, 16.0);
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideCubit, RideState>(
      listener: (context, state) {
        if (state is RideCompleted) {
          context.pushReplacement('/home/trip-summary');
        } else if (state is RideInitial) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        if (state is! RideActive) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final ride = state.activeRide;

        return Scaffold(
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
              const ActiveTripAppBar(),
              const ActiveTripNextTurn(),
              ActiveTripMapControls(onLocationPressed: _getUserLocation),
              ActiveTripDetailsSheet(ride: ride),
            ],
          ),
        );
      },
    );
  }
}
