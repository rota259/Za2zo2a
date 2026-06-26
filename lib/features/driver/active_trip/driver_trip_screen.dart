import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../trip/data/models/trip_models.dart';
import 'driver_trip_cubit.dart';
import 'driver_trip_state.dart';

class DriverTripScreen extends StatefulWidget {
  const DriverTripScreen({super.key});

  @override
  State<DriverTripScreen> createState() => _DriverTripScreenState();
}

class _DriverTripScreenState extends State<DriverTripScreen>
    with WidgetsBindingObserver {
  final _mapController = MapController();
  final _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pinController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<DriverTripCubit>();
    if (state == AppLifecycleState.resumed) {
      cubit.resume();
    } else {
      cubit.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DriverTripCubit, DriverTripState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              _buildMap(state),
              Align(
                alignment: Alignment.bottomCenter,
                child: _panel(context, state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMap(DriverTripState state) {
    final pickup = state.trip?.origin?.latLng;
    final dest = state.trip?.destination?.latLng;
    final driver = state.driverLocation;
    final center = driver ?? pickup ?? const LatLng(30.0444, 31.2357);

    final markers = <Marker>[
      if (driver != null)
        _marker(driver, Icons.local_taxi, AppColors.secondary),
      if (pickup != null) _marker(pickup, Icons.my_location, AppColors.primary),
      if (dest != null) _marker(dest, Icons.location_on, AppColors.darkRed),
    ];

    // While heading: driver→pickup route; in-progress: pickup→dest.
    final line = state.headingRoute.isNotEmpty &&
            state.status == TripStatus.accepted
        ? state.headingRoute
        : (state.trip?.routePoints.isNotEmpty ?? false)
            ? state.trip!.routePoints
            : [?pickup, ?dest];

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: AppConstants.initialMapZoom,
        minZoom: AppConstants.minZoom,
        maxZoom: AppConstants.maxZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: AppConstants.osmTileUrl,
          userAgentPackageName: AppConstants.tileUserAgentPackageName,
        ),
        if (line.length >= 2)
          PolylineLayer(
            polylines: [
              Polyline(points: line, strokeWidth: 4, color: AppColors.primary),
            ],
          ),
        MarkerLayer(markers: markers),
      ],
    );
  }

  Marker _marker(LatLng p, IconData icon, Color color) => Marker(
        point: p,
        width: 44,
        height: 44,
        child: Icon(icon, color: color, size: 34),
      );

  Widget _panel(BuildContext context, DriverTripState state) {
    final child = switch (state.status) {
      TripStatus.accepted => _headingPanel(context, state),
      TripStatus.inProgress => _inProgressPanel(context, state),
      TripStatus.completed => _completedPanel(context, state),
      TripStatus.cancelled => _cancelledPanel(context, state),
      _ => _cancelledPanel(context, state),
    };
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.55,
      ),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(child: child),
      ),
    );
  }

  Widget _riderRow(BuildContext context, DriverTripState state) => Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            child: Icon(Icons.person, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              state.trip?.riderName ?? 'Rider',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      );

  Widget _headingPanel(BuildContext context, DriverTripState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Head to pickup',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        _riderRow(context, state),
        const SizedBox(height: 8),
        if (state.trip?.origin?.address != null)
          Row(
            children: [
              Icon(Icons.my_location, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(child: Text(state.trip!.origin!.address!)),
            ],
          ),
        const SizedBox(height: 16),
        // Navigate to pickup via Google Maps
        if (state.trip?.origin != null)
          OutlinedButton.icon(
            icon: const Icon(Icons.navigation_outlined),
            label: const Text('Navigate to Pickup',
                style: TextStyle(fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              final lat = state.trip!.origin!.lat;
              final lng = state.trip!.origin!.lng;
              final uri = Uri.parse(
                  'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
          ),
        const SizedBox(height: 12),
        if (!state.arrived)
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () => context.read<DriverTripCubit>().markArrived(),
            child: const Text('Arrived at pickup'),
          )
        else
          // PIN disabled for now — start trip directly
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: state.actionInFlight
                ? null
                : () => context.read<DriverTripCubit>().startTripNoPIN(),
            child: state.actionInFlight
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Text('Start Trip'),
          ),
      ],
    );
  }

  Widget _inProgressPanel(BuildContext context, DriverTripState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Trip in progress',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        if (state.trip?.destination?.address != null)
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: AppColors.darkRed),
              const SizedBox(width: 6),
              Expanded(child: Text(state.trip!.destination!.address!)),
            ],
          ),
        const SizedBox(height: 12),
        if (state.trip?.destination != null)
          OutlinedButton.icon(
            icon: const Icon(Icons.navigation_outlined),
            label: const Text('Navigate to Destination',
                style: TextStyle(fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              final lat = state.trip!.destination!.lat;
              final lng = state.trip!.destination!.lng;
              final uri = Uri.parse(
                  'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
          ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: state.actionInFlight
              ? null
              : () => context.read<DriverTripCubit>().complete(),
          child: state.actionInFlight
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : const Text('Complete trip'),
        ),
      ],
    );
  }

  Widget _completedPanel(BuildContext context, DriverTripState state) {
    final fare = state.trip?.fare;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 44),
        const SizedBox(height: 10),
        Text('Trip completed',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge),
        if (fare != null) ...[
          const SizedBox(height: 8),
          Center(
            child: Text('You earned EGP ${fare.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => context.go('/driver/home'),
          child: const Text('Back to dispatch'),
        ),
      ],
    );
  }

  Widget _cancelledPanel(BuildContext context, DriverTripState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.info_outline, color: AppColors.darkRed, size: 40),
        const SizedBox(height: 10),
        Text(
          state.status == TripStatus.cancelled
              ? 'This trip was cancelled'
              : 'Trip ended',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (state.trip?.cancelReason != null) ...[
          const SizedBox(height: 6),
          Text('Reason: ${state.trip!.cancelReason}',
              textAlign: TextAlign.center),
        ],
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => context.go('/driver/home'),
          child: const Text('Back to dispatch'),
        ),
      ],
    );
  }
}
