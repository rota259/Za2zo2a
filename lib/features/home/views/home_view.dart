import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  final MapController _mapController = MapController();

  void _onGpsTap(LatLng? coords) {
    if (coords != null) {
      _mapController.move(coords, 15.0);
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

        final LatLng center =
            (state is HomeLoaded && state.currentLocationCoords != null)
                ? state.currentLocationCoords!
                : const LatLng(30.0444, 31.2357);

        return Scaffold(
          key: _scaffoldKey,
          drawer: const AppDrawer(),
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.flutter_tasks_mostafa',
                  ),
                ],
              ),
              HomeTopBar(
                scaffoldKey: _scaffoldKey,
                onGpsTap:
                    () => _onGpsTap(
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
        );
      },
    );
  }
}
