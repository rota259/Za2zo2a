import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../map/domain/usecases/get_user_location_use_case.dart';
import '../../map/presentation/view/map_view.dart';
import '../../map/presentation/viewmodel/map_cubit.dart';
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
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initLocation();
  }

  @override
  void dispose() {
    _mapCubit.close();
    super.dispose();
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
          body: BlocProvider.value(
            value: _mapCubit,
            child: Stack(
              children: [
                const Positioned.fill(child: MapView.embedded()),
                const ActiveTripAppBar(),
                const ActiveTripNextTurn(),
                ActiveTripMapControls(
                  onLocationPressed: () {
                    final userLocation =
                        _mapCubit.lastLoadedState?.userLocation;

                    if (userLocation != null) {
                      _mapCubit.moveToLocation(userLocation);
                    } else {
                      _mapCubit.initLocation();
                    }
                  },
                ),
                ActiveTripDetailsSheet(ride: ride),
              ],
            ),
          ),
        );
      },
    );
  }
}
