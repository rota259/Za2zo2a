import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/trip_models.dart';
import 'trip_tracking_cubit.dart';
import 'trip_tracking_state.dart';

/// Screen the rider lands on after requesting a trip. Polls trip status live
/// and reflects each phase. Pauses polling while backgrounded.
class TripTrackingScreen extends StatefulWidget {
  const TripTrackingScreen({super.key});

  @override
  State<TripTrackingScreen> createState() => _TripTrackingScreenState();
}

class _TripTrackingScreenState extends State<TripTrackingScreen>
    with WidgetsBindingObserver {
  final _mapController = MapController();
  int _rating = 5;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _commentController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<TripTrackingCubit>();
    if (state == AppLifecycleState.resumed) {
      cubit.resume();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      cubit.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TripTrackingCubit, TripTrackingState>(
        builder: (context, state) {
          if (state.loadingInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              _buildMap(state),
              if (state.error != null) _errorBanner(state.error!),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildPanel(context, state),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Map ────────────────────────────────────────────────────────────────
  Widget _buildMap(TripTrackingState state) {
    final origin = state.trip?.origin?.latLng;
    final dest = state.trip?.destination?.latLng;
    final route = state.trip?.routePoints ?? const <LatLng>[];
    final center = origin ?? dest ?? const LatLng(30.0444, 31.2357);

    final markers = <Marker>[
      if (origin != null)
        _marker(origin, Icons.my_location, AppColors.primary),
      if (dest != null) _marker(dest, Icons.location_on, AppColors.darkRed),
    ];

    final line = route.isNotEmpty
        ? route
        : [?origin, ?dest];

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
              Polyline(
                points: line,
                strokeWidth: 4,
                color: AppColors.primary,
              ),
            ],
          ),
        MarkerLayer(markers: markers),
      ],
    );
  }

  Marker _marker(LatLng point, IconData icon, Color color) => Marker(
        point: point,
        width: 44,
        height: 44,
        child: Icon(icon, color: color, size: 36),
      );

  // ── Status panel ─────────────────────────────────────────────────────────
  Widget _buildPanel(BuildContext context, TripTrackingState state) {
    final child = switch (state.status) {
      TripStatus.requested => _requestedPanel(context, state),
      TripStatus.accepted => _acceptedPanel(context, state),
      TripStatus.inProgress => _inProgressPanel(context, state),
      TripStatus.completed => _completedPanel(context, state),
      TripStatus.cancelled => _cancelledPanel(context, state),
      TripStatus.unknown => _unknownPanel(context, state),
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

  Widget _requestedPanel(BuildContext context, TripTrackingState state) {
    if (state.searchTimedOut) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.search_off, size: 40, color: AppColors.darkRed),
          const SizedBox(height: 12),
          Text('No drivers found nearby',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          const Text('You can keep waiting or cancel and try again.',
              textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: state.actionInFlight
                      ? null
                      : () => _confirmCancel(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: state.actionInFlight
                      ? null
                      : () => context.read<TripTrackingCubit>().retry(),
                  child: const Text('Keep searching'),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text('Looking for a driver…',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed:
              state.actionInFlight ? null : () => _confirmCancel(context),
          child: const Text('Cancel request'),
        ),
      ],
    );
  }

  Widget _acceptedPanel(BuildContext context, TripTrackingState state) {
    final driver = state.driver;
    final pin = state.trip?.pin;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Driver on the way',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: Icon(Icons.person, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(driver?.name ?? 'Your driver',
                      style: Theme.of(context).textTheme.titleMedium),
                  if (driver?.vehicleInfo != null)
                    Text(driver!.vehicleInfo!.displayName,
                        style: Theme.of(context).textTheme.bodySmall),
                  if (driver?.vehicleInfo?.plate != null)
                    Text('Plate: ${driver!.vehicleInfo!.plate}',
                        style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            if (driver?.rating != null)
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  Text(driver!.rating!.toStringAsFixed(1)),
                ],
              ),
          ],
        ),
        const SizedBox(height: 16),
        // PIN shown prominently — the driver needs it to start the trip.
        if (pin != null && pin.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                const Text('Share this PIN with your driver'),
                const SizedBox(height: 6),
                Text(
                  pin,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed:
              state.actionInFlight ? null : () => _confirmCancel(context),
          child: const Text('Cancel trip'),
        ),
      ],
    );
  }

  Widget _inProgressPanel(BuildContext context, TripTrackingState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.navigation, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text('On the way to your destination',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
        if (state.trip?.destination?.address != null) ...[
          const SizedBox(height: 8),
          Text(state.trip!.destination!.address!,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ],
    );
  }

  Widget _completedPanel(BuildContext context, TripTrackingState state) {
    if (state.rated) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 44),
          const SizedBox(height: 10),
          const Text('Thanks for your feedback!'),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Done'),
            ),
          ),
        ],
      );
    }
    final fare = state.trip?.fare;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Trip completed',
            style: Theme.of(context).textTheme.titleLarge),
        if (fare != null) ...[
          const SizedBox(height: 8),
          Text('Fare: EGP ${fare.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium),
        ],
        const SizedBox(height: 16),
        const Text('Rate your driver'),
        const SizedBox(height: 8),
        Center(
          child: RatingBar.builder(
            initialRating: _rating.toDouble(),
            minRating: 1,
            allowHalfRating: false,
            itemCount: 5,
            itemBuilder: (context, index) =>
                const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (v) => _rating = v.toInt(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(
            hintText: 'Add a comment (optional)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        ElevatedButton(
          onPressed: state.actionInFlight
              ? null
              : () => context.read<TripTrackingCubit>().rate(
                    rating: _rating,
                    comment: _commentController.text.trim().isEmpty
                        ? null
                        : _commentController.text.trim(),
                  ),
          child: state.actionInFlight
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : const Text('Submit rating'),
        ),
      ],
    );
  }

  Widget _cancelledPanel(BuildContext context, TripTrackingState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.cancel, color: AppColors.darkRed, size: 40),
        const SizedBox(height: 10),
        Text('Trip cancelled',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium),
        if (state.trip?.cancelReason != null) ...[
          const SizedBox(height: 6),
          Text('Reason: ${state.trip!.cancelReason}',
              textAlign: TextAlign.center),
        ],
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => context.go('/home'),
          child: const Text('Back to home'),
        ),
      ],
    );
  }

  Widget _unknownPanel(BuildContext context, TripTrackingState state) {
    // BACKEND TODO: status value not recognised — confirm server statuses.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.help_outline, size: 36),
        const SizedBox(height: 8),
        Text('Trip status: ${state.trip?.rawStatus ?? 'unknown'}'),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => context.go('/home'),
          child: const Text('Back to home'),
        ),
      ],
    );
  }

  Widget _errorBanner(String message) => Positioned(
        top: MediaQuery.of(context).padding.top + 8,
        left: 12,
        right: 12,
        child: Material(
          color: AppColors.darkRed,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.wifi_off, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(message,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _confirmCancel(BuildContext context) async {
    final cubit = context.read<TripTrackingCubit>();
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel trip?'),
        content: const Text('Are you sure you want to cancel this trip?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No, keep it'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'Cancelled by rider'),
            child: const Text('Yes, cancel'),
          ),
        ],
      ),
    );
    if (reason != null) {
      cubit.cancel(reason: reason);
    }
  }
}
