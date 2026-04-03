import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../view_model/map_cubit.dart';
import '../view_model/map_state.dart';
import 'widgets/map_marker_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit()..fetchUserLocation(),
      child: const _MapScreenView(),
    );
  }
}

class _MapScreenView extends StatefulWidget {
  const _MapScreenView();

  @override
  State<_MapScreenView> createState() => _MapScreenViewState();
}

class _MapScreenViewState extends State<_MapScreenView>
    with TickerProviderStateMixin {
  late final AnimatedMapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    context.read<MapCubit>().setDestinationAndFetchRoute(point);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          if (state is MapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          } else if (state is MapReady) {
            // Adjust camera view when new data arrives
            if (state.route != null && state.destination != null) {
              final bounds = LatLngBounds.fromPoints([
                state.userLocation,
                state.destination!,
                if (state.driverMockLocation != null) state.driverMockLocation!,
                ...state.route!.polylinePoints,
              ]);
              _mapController.animatedFitCamera(
                cameraFit: CameraFit.bounds(
                  bounds: bounds,
                  padding: EdgeInsets.all(context.widthPct(40)),
                ),
              );
            } else {
              _mapController.animateTo(dest: state.userLocation, zoom: 15.0);
            }
          }
        },
        builder: (context, state) {
          if (state is MapInitial) {
            return _buildLoading('Initializing map...');
          }

          if (state is MapLoading) {
            return _buildLoading(state.message);
          }

          if (state is MapReady) {
            return Stack(
              children: [
                FlutterMap(
                  mapController: _mapController.mapController,
                  options: MapOptions(
                    initialCenter: state.userLocation,
                    initialZoom: 15.0,
                    onTap: _onMapTap,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.flutter_tasks_mostafa',
                    ),
                    if (state.route != null &&
                        state.route!.polylinePoints.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: state.route!.polylinePoints,
                            color: AppColors.primary,
                            strokeWidth: 4.0,
                            pattern: const StrokePattern.solid(),
                          ),
                        ],
                      ),
                    MarkerLayer(
                      markers: [
                        // User Location Marker
                        Marker(
                          point: state.userLocation,
                          width: context.widthPct(50),
                          height: context.widthPct(50),
                          child: const MapMarkerWidget(type: MarkerType.user),
                        ),

                        // Destination Marker
                        if (state.destination != null)
                          Marker(
                            point: state.destination!,
                            width: context.widthPct(50),
                            height: context.widthPct(60),
                            alignment: Alignment.topCenter,
                            child: const MapMarkerWidget(
                              type: MarkerType.destination,
                            ),
                          ),

                        // Driver Mock Marker
                        if (state.driverMockLocation != null)
                          Marker(
                            point: state.driverMockLocation!,
                            width: context.widthPct(50),
                            height: context.widthPct(50),
                            child: const MapMarkerWidget(
                              type: MarkerType.driver,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                // Overlay UI Data
                if (state.route != null) _buildRouteInfoCard(context, state),

                _buildFloatingActions(context, state),
              ],
            );
          }

          if (state is MapError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: context.widthPct(60),
                    color: AppColors.error,
                  ),
                  SizedBox(height: context.heightPct(16)),
                  Text(state.error, style: AppTextStyles.bodyMedium(context)),
                  SizedBox(height: context.heightPct(16)),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<MapCubit>().fetchUserLocation(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoading(String message) {
    return Container(
      color: AppColors.background,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(message, style: AppTextStyles.bodyLarge(context)),
        ],
      ),
    );
  }

  Widget _buildRouteInfoCard(BuildContext context, MapReady state) {
    // Distance comes back in meters roughly, usually. OSRM returns meters and seconds.
    final distKm = (state.route!.distance / 1000).toStringAsFixed(1);
    final mins = (state.route!.duration / 60).toStringAsFixed(0);

    return Positioned(
      top: context.heightPct(60),
      left: context.widthPct(16),
      right: context.widthPct(16),
      child: Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Distance: $distKm km', style: AppTextStyles.h3(context)),
                Text(
                  'Est Duration: $mins mins',
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
            if (state.driverMockLocation == null)
              ElevatedButton(
                onPressed: () =>
                    context.read<MapCubit>().simulateDriverMovement(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Start Simulation',
                  style: TextStyle(color: Colors.white),
                ),
              )
            else
              ElevatedButton(
                onPressed: () => context.read<MapCubit>().cancelSimulation(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                child: const Text(
                  'Stop Simulation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActions(BuildContext context, MapReady state) {
    return Positioned(
      bottom: context.heightPct(40),
      right: context.widthPct(16),
      child: Column(
        children: [
          if (state.destination != null)
            Padding(
              padding: EdgeInsets.only(bottom: context.heightPct(16)),
              child: FloatingActionButton(
                heroTag: 'clear',
                backgroundColor: AppColors.background,
                onPressed: () => context.read<MapCubit>().clearDestination(),
                child: Icon(Icons.clear, color: AppColors.error),
              ),
            ),
          FloatingActionButton(
            heroTag: 'locate',
            backgroundColor: AppColors.primary,
            onPressed: () => context.read<MapCubit>().fetchUserLocation(),
            child: const Icon(Icons.my_location, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
