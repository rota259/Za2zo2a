import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_home_cubit.dart';
import '../cubit/driver_home_state.dart';
import '../../../../features/home/views/widgets/map_floating_button.dart';
import '../../driver_trip/cubit/driver_trip_cubit.dart';
import '../../driver_trip/data/models/driver_trip_model.dart';
import '../widgets/driver_top_app_bar.dart';
import '../widgets/driver_stats_row.dart';
import '../widgets/driver_bonus_card.dart';
import '../widgets/driver_offline_button.dart';
import '../widgets/driver_available_trips.dart';
import '../widgets/driver_bottom_nav.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {
  final MapController _mapController = MapController();

  void _onGpsTap(LatLng? coords) {
    if (coords != null) {
      _mapController.move(coords, 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {
        if (state is DriverHomeRequestAccepted) {
          final req = state.request;
          final trip = DriverTripModel(
            id: req.id,
            riderName: req.riderName,
            riderPhoto: req.riderPhoto,
            riderRating: req.riderRating,
            pickupAddress: req.pickupAddress,
            destinationAddress: req.destinationAddress,
            distanceKm: req.distanceKm,
            durationMinutes: req.estimatedMinutes,
            fare: req.fare,
            paymentMethod: req.paymentMethod,
            rideType: req.rideType,
            status: 'heading_to_pickup',
            createdAt: DateTime.now(),
          );
          context.read<DriverTripCubit>().startHeadingToPickup(trip);
          context.push('/driver/active-trip');
        }
      },
      builder: (context, state) {
        final isOnline =
            state is DriverHomeOnline || state is DriverHomeRequestReceived;
        final hasRequest = state is DriverHomeRequestReceived;

        return Scaffold(
          backgroundColor: AppColors.grey100,
          body: hasRequest
              ? DriverAvailableTrips(req: (state).request)
              : _buildOfflineOrWaitingView(state, isOnline),
          bottomNavigationBar: const DriverBottomNav(),
        );
      },
    );
  }

  Widget _buildOfflineOrWaitingView(DriverHomeState state, bool isOnline) {
    final LatLng center = state.currentLocationCoords ?? const LatLng(30.0444, 31.2357);
    
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: center,
            initialZoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.flutter_tasks_mostafa',
            ),
          ],
        ),
        Center(
          child: Container(
            width: context.widthPct(40),
            height: context.widthPct(40),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: context.widthPct(16),
                height: context.widthPct(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              DriverTopAppBar(isOnline: isOnline),
              const DriverStatsRow(),
              SizedBox(height: context.heightPct(16)),
              const DriverBonusCard(),
            ],
          ),
        ),
        Positioned(
          bottom: context.heightPct(100),
          right: context.widthPct(16),
          child: MapFloatingButton(
            icon: Icons.gps_fixed,
            onTap: () => _onGpsTap(state.currentLocationCoords),
          ),
        ),
        DriverOfflineButton(isOnline: isOnline),
      ],
    );
  }
}
