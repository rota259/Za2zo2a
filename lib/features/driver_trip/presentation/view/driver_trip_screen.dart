import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/usecases/navigate_to_destination_usecase.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';
import '../widgets/destination_panel.dart';
import '../widgets/driver_map_widget.dart';
import '../widgets/driver_nav_card.dart';
import '../widgets/driver_top_bar.dart';

class DriverTripScreen extends StatelessWidget {
  final String rideId;

  const DriverTripScreen({super.key, required this.rideId});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverTripCubit>();

    return BlocConsumer<DriverTripCubit, DriverTripState>(
      listener: (context, state) {
        if (state is DriverTripError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is DriverTripEnded) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        final snapshot = state is DriverTripActive ? state : cubit.lastSnapshot;
        if (snapshot == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isTablet =
                constraints.maxWidth >= AppConstants.tabletBreakpoint;
            final mapColumn = Column(
              children: [
                const DriverTopBar(),
                DriverNavCard(
                  distanceToTurn: snapshot.distanceToTurn,
                  turnInstruction: snapshot.turnInstruction,
                  eta: snapshot.eta,
                ),
                const SizedBox(height: 12),
                Expanded(child: DriverMapWidget(route: snapshot.route)),
              ],
            );
            final panel = DestinationPanel(
              isTablet: isTablet,
              destination: snapshot.destination,
              distanceKm: snapshot.distanceKm,
              tripTime: snapshot.tripTime,
              onNavigate: () => _handleNavigation(context, cubit),
              onEndTrip: cubit.endTrip,
            );

            return Scaffold(
              body: SafeArea(
                child: isTablet
                    ? Row(
                        children: [
                          Expanded(flex: 60, child: mapColumn),
                          Expanded(child: panel),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(child: mapColumn),
                          panel,
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleNavigation(
    BuildContext context,
    DriverTripCubit cubit,
  ) async {
    final result = await cubit.navigateToDestination();
    if (!context.mounted) {
      return;
    }
    if (result == NavigationLaunchStatus.noDestination) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.noDestinationSet)),
      );
    }
    if (result == NavigationLaunchStatus.failed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.couldNotOpenMaps)),
      );
    }
  }
}
