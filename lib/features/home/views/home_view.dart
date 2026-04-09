import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../map/domain/usecases/get_user_location_use_case.dart';
import '../../map/presentation/view/map_view.dart';
import '../../map/presentation/viewmodel/map_cubit.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'widgets/app_drawer.dart';
import 'widgets/where_to_sheet.dart';
import 'widgets/destination_sheet.dart';
import 'widgets/home_top_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  void _onGpsTap(LatLng? coords) {
    final target = coords ?? _mapCubit.lastLoadedState?.userLocation;

    if (target != null) {
      _mapCubit.moveToLocation(target);
    } else {
      _mapCubit.initLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final bool hasDest =
            state is HomeLoaded &&
            state.selectedDestination != null &&
            state.selectedDestination!.isNotEmpty;

        return BlocProvider.value(
          value: _mapCubit,
          child: Scaffold(
            key: _scaffoldKey,
            drawer: const AppDrawer(),
            body: Stack(
              children: [
                const Positioned.fill(child: MapView.embedded()),
                HomeTopBar(
                  scaffoldKey: _scaffoldKey,
                  onGpsTap: () => _onGpsTap(
                    state is HomeLoaded ? state.currentLocationCoords : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: hasDest
                      ? DestinationSheet(state: state)
                      : const WhereToSheet(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
