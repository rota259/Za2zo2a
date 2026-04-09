import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../map/domain/usecases/get_user_location_use_case.dart';
import '../../../map/presentation/view/map_view.dart';
import '../../../map/presentation/viewmodel/map_cubit.dart';
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
          body: BlocProvider.value(
            value: _mapCubit,
            child: Stack(
              children: [
                const Positioned.fill(child: MapView.embedded()),
                const DriverActiveTripAppBar(),
                const DriverActiveTripNextTurn(),
                DriverActiveTripControls(
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
                DriverActiveTripSheet(isHeadingToPickup: isHeadingToPickup),
              ],
            ),
          ),
        );
      },
    );
  }
}
