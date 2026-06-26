import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_colors.dart';
import '../../trip/data/models/trip_models.dart';
import 'driver_dispatch_cubit.dart';
import 'driver_dispatch_state.dart';

/// Driver home/matching screen: go online, see nearest open requests, accept.
class DriverDispatchScreen extends StatefulWidget {
  const DriverDispatchScreen({super.key});

  @override
  State<DriverDispatchScreen> createState() => _DriverDispatchScreenState();
}

class _DriverDispatchScreenState extends State<DriverDispatchScreen>
    with WidgetsBindingObserver {
  static const Distance _distance = Distance();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<DriverDispatchCubit>();
    if (state == AppLifecycleState.resumed) {
      cubit.resume();
    } else {
      cubit.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            onPressed: () => context.push('/driver/earnings'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/driver/profile'),
          ),
        ],
      ),
      body: BlocConsumer<DriverDispatchCubit, DriverDispatchState>(
        listener: (context, state) {
          if (state.acceptedTrip != null) {
            final id = state.acceptedTrip!.id;
            context.read<DriverDispatchCubit>().consumeAccepted();
            context.push('/driver/trip/$id');
          }
          if (state.message != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              _onlineCard(context, state),
              const Divider(height: 1),
              Expanded(child: _body(context, state)),
            ],
          );
        },
      ),
    );
  }

  Widget _onlineCard(BuildContext context, DriverDispatchState state) {
    final cubit = context.read<DriverDispatchCubit>();
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            state.isOnline ? Icons.bolt : Icons.power_settings_new,
            color: state.isOnline ? AppColors.primary : Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              state.isOnline ? 'You are online' : 'You are offline',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (state.toggling)
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2.4),
            )
          else
            Switch(
              value: state.isOnline,
              activeThumbColor: AppColors.primary,
              onChanged: (v) => v ? cubit.goOnline() : cubit.goOffline(),
            ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, DriverDispatchState state) {
    if (!state.isOnline) {
      return const _Centered(
        icon: Icons.power_settings_new,
        text: 'Go online to start receiving ride requests.',
      );
    }
    if (state.loadingTrips && state.trips.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.trips.isEmpty) {
      return const _Centered(
        icon: Icons.hourglass_empty,
        text: 'Waiting for ride requests…',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.trips.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) =>
          _tripCard(context, state, state.trips[i]),
    );
  }

  Widget _tripCard(
    BuildContext context,
    DriverDispatchState state,
    TripModel trip,
  ) {
    final accepting = state.acceptingIds.contains(trip.id);
    final km = (state.driverLocation != null && trip.origin != null)
        ? _distance(state.driverLocation!, trip.origin!.latLng) / 1000
        : null;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row(Icons.my_location, AppColors.primary,
                trip.origin?.address ?? 'Pickup'),
            const SizedBox(height: 8),
            _row(Icons.location_on, AppColors.darkRed,
                trip.destination?.address ?? 'Destination'),
            const SizedBox(height: 12),
            Row(
              children: [
                if (km != null) ...[
                  const Icon(Icons.directions_car, size: 16),
                  const SizedBox(width: 4),
                  Text('${km.toStringAsFixed(1)} km away'),
                  const Spacer(),
                ] else
                  const Spacer(),
                if (trip.fare != null)
                  Text('EGP ${trip.fare!.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                onPressed: accepting
                    ? null
                    : () => context.read<DriverDispatchCubit>().accept(trip.id),
                child: accepting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Text('Accept'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(IconData icon, Color color, String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      );
}

class _Centered extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Centered({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
