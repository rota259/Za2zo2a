import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../cubit/active_ride_cubit.dart';
import '../cubit/active_ride_state.dart';
import '../widgets/active_ride_map_widget.dart';
import '../widgets/driver_info_card.dart';
import '../widgets/ride_action_buttons.dart';

class ActiveRideScreen extends StatefulWidget {
  final String rideId;
  final LatLng? origin;
  final LatLng? destination;

  const ActiveRideScreen({
    super.key,
    required this.rideId,
    this.origin,
    this.destination,
  });

  @override
  State<ActiveRideScreen> createState() => _ActiveRideScreenState();
}

class _ActiveRideScreenState extends State<ActiveRideScreen> {
  bool _hasStartedRide = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _hasStartedRide) {
        return;
      }
      _hasStartedRide = true;
      context.read<ActiveRideCubit>().startRide(
        widget.rideId,
        origin: widget.origin,
        destination: widget.destination,
      );
    });
  }

  Future<void> _openExternalNavigation() async {
    final state = context.read<ActiveRideCubit>().state;
    if (state is! ActiveRideInProgress) {
      return;
    }
    final dest = state.destination;
    if (dest == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.noDestinationAvailable)),
      );
      return;
    }

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${dest.latitude},${dest.longitude}'
      '&travelmode=driving',
    );
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.couldNotOpenMaps)),
      );
    }
  }

  Future<void> _retryRide() {
    return context.read<ActiveRideCubit>().startRide(
      widget.rideId,
      origin: widget.origin,
      destination: widget.destination,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActiveRideCubit>();

    return BlocConsumer<ActiveRideCubit, ActiveRideState>(
      listener: (context, state) {
        if (state is ActiveRideError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                action: SnackBarAction(
                  label: AppStrings.retry,
                  onPressed: _retryRide,
                ),
              ),
            );
        }
        if (state is ActiveRideCompleted) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        final snapshot = state is ActiveRideInProgress
            ? state
            : cubit.lastSnapshot;
        if (snapshot == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isTablet =
                constraints.maxWidth >= AppConstants.tabletBreakpoint;
            final map = SizedBox(
              height: isTablet
                  ? double.infinity
                  : MediaQuery.sizeOf(context).height *
                        AppConstants.rideMapHeightFactor,
              child: ActiveRideMapWidget(
                route: snapshot.route,
                instruction: snapshot.turnInstruction,
              ),
            );
            final panel = _RidePanel(
              isTablet: isTablet,
              eta: snapshot.eta,
              arrivalTime: _arrivalTime(snapshot.route.durationSeconds),
              distanceKm: snapshot.distanceKm,
              tripProgress: snapshot.tripProgress,
              onNavigate: _openExternalNavigation,
              driverInfoCard: DriverInfoCard(driverInfo: snapshot.driverInfo),
              actionButtons: RideActionButtons(
                onShareStatus: () {},
                onEmergency: () => context.go('/safety'),
              ),
            );

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: context.pop,
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text(
                  AppStrings.rideInProgress,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
                backgroundColor: AppColors.background,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
              ),
              body: SafeArea(
                top: false,
                child: isTablet
                    ? Row(
                        children: [
                          Expanded(flex: 58, child: map),
                          Expanded(child: panel),
                        ],
                      )
                    : Column(
                        children: [
                          map,
                          Expanded(child: panel),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }

  String _arrivalTime(double durationSeconds) {
    final arrival = DateTime.now().add(
      Duration(seconds: durationSeconds.round()),
    );
    final hour = arrival.hour.toString().padLeft(2, '0');
    final minute = arrival.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _RidePanel extends StatelessWidget {
  final bool isTablet;
  final String eta;
  final String arrivalTime;
  final String distanceKm;
  final double tripProgress;
  final Widget driverInfoCard;
  final Widget actionButtons;
  final Future<void> Function() onNavigate;

  const _RidePanel({
    required this.isTablet,
    required this.eta,
    required this.arrivalTime,
    required this.distanceKm,
    required this.tripProgress,
    required this.driverInfoCard,
    required this.actionButtons,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final radius = isTablet
        ? BorderRadius.circular(24)
        : const BorderRadius.vertical(top: Radius.circular(24));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: radius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                eta,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline),
              ),
            ],
          ),
          Text(
            '${AppStrings.arrivingAt} $arrivalTime - $distanceKm ${AppStrings.distanceUnitKm}',
            style: TextStyle(color: AppColors.greyText),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: tripProgress,
            minHeight: 6,
            borderRadius: BorderRadius.circular(999),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            backgroundColor: AppColors.grey200,
          ),
          driverInfoCard,
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: onNavigate,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.navigation_outlined, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.navigateToDestination,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          actionButtons,
        ],
      ),
    );
  }
}
