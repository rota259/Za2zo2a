import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    // Initialize map and location
    context.read<MapCubit>().initMap();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    if (!mounted || !_isMapReady) return;
    
    final latTween = Tween<double>(
      begin: _mapController.camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: _mapController.camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(
      begin: _mapController.camera.zoom,
      end: destZoom,
    );

    final controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          if (state is MapLoaded) {
             if (state.destinationLocation != null && !state.driverFound) {
                // Focus on route between pickup and destination
                // For simplicity, just moving to pickup initially
                _animatedMapMove(state.pickupLocation, 14.0);
             } else {
                _animatedMapMove(state.currentLocation, 16.0);
             }
          }
          if (state is MapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is MapLoading || state is MapInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is MapError) {
            return Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('Failed to load map: ${state.message}'),
                   ElevatedButton(
                     onPressed: () => context.read<MapCubit>().initMap(),
                     child: const Text('Retry'),
                   )
                 ]
               )
            );
          }

          if (state is MapLoaded) {
            return Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: state.currentLocation,
                    initialZoom: 16.0,
                    onMapReady: () {
                      _isMapReady = true;
                    },
                    onTap: (tapPosition, point) {
                      // Allow selecting destination by tapping on map if not set
                      if (state.destinationLocation == null) {
                         // We could set destination here or just pickup
                         context.read<MapCubit>().setDestination(point);
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                      subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                      userAgentPackageName: 'com.example.app',
                      maxZoom: 20,
                    ),
                    if (state.destinationLocation != null)
                       PolylineLayer(
                         polylines: [
                           Polyline(
                             points: [state.pickupLocation, state.destinationLocation!],
                             color: AppColors.primary,
                             strokeWidth: 4.0,
                           ),
                         ],
                       ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: state.pickupLocation,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.person_pin_circle,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                        if (state.destinationLocation != null)
                          Marker(
                            point: state.destinationLocation!,
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.location_on,
                              color: AppColors.error,
                              size: 40,
                            ),
                          ),
                        if (state.driverFound && state.driverLocation != null)
                          Marker(
                            point: state.driverLocation!,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.directions_car,
                              color: Colors.black87,
                              size: 40,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                // Back Button
                Positioned(
                  top: context.heightPct(50),
                  left: context.widthPct(16),
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ),
                ),

                // Bottom Sheet Flow
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildBottomSheet(context, state),
                ),
              ],
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context, MapLoaded state) {
    if (state.driverFound) {
      return _buildDriverFoundSheet(context);
    } else if (state.isFindingDriver) {
      return _buildFindingDriverSheet(context);
    } else if (state.destinationLocation != null) {
       return _buildConfirmRideSheet(context, state);
    } else {
       return _buildSelectDestinationSheet(context);
    }
  }

  Widget _buildSelectDestinationSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(24),
        vertical: context.heightPct(24),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.widthPct(24))),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Tap on the map to set destination', style: AppTextStyles.h3(context)),
             SizedBox(height: context.heightPct(16)),
             Text('Or search for a place (simulation)', style: AppTextStyles.bodyMedium(context)),
             SizedBox(height: context.heightPct(20)),
             // Mock search box
             Container(
               padding: EdgeInsets.all(context.widthPct(16)),
               decoration: BoxDecoration(
                 color: AppColors.grey100,
                 borderRadius: BorderRadius.circular(12),
               ),
               child: Row(
                 children: [
                    Icon(Icons.search, color: AppColors.textSecondary),
                    SizedBox(width: context.widthPct(12)),
                    Text('Search destination...', style: TextStyle(color: AppColors.textSecondary)),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmRideSheet(BuildContext context, MapLoaded state) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(24),
        vertical: context.heightPct(24),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.widthPct(24))),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Destination selected', style: AppTextStyles.h3(context)),
            SizedBox(height: context.heightPct(20)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: context.heightPct(16)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                context.read<MapCubit>().findDriver();
              },
              child: Text(
                'Find Driver',
                 style: AppTextStyles.button(context).copyWith(color: Colors.white),
              ),
            ),
             SizedBox(height: context.heightPct(10)),
             TextButton(
               onPressed: () => context.read<MapCubit>().resetRide(),
               child: Text('Cancel', style: TextStyle(color: AppColors.error)),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildFindingDriverSheet(BuildContext context) {
     return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(24),
        vertical: context.heightPct(30),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.widthPct(24))),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: context.heightPct(20)),
            Text('Looking for nearby drivers...', style: AppTextStyles.h3(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverFoundSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(24),
        vertical: context.heightPct(24),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.widthPct(24))),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Row(
               children: [
                 CircleAvatar(
                   backgroundColor: AppColors.grey200,
                   child: const Icon(Icons.person, color: Colors.black54),
                 ),
                 SizedBox(width: context.widthPct(16)),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Driver Found!', style: AppTextStyles.h3(context)),
                     Text('Toyota Camry • ABC 123', style: AppTextStyles.bodyMedium(context)),
                   ],
                 ),
                 const Spacer(),
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                   decoration: BoxDecoration(
                     color: AppColors.primary.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(8),
                   ),
                   child: Text('4.9 ★', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                 ),
               ],
             ),
             SizedBox(height: context.heightPct(20)),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: context.heightPct(16)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // In a real app we'd navigate to active trip. Simulating completion.
                context.read<MapCubit>().resetRide();
                context.pop();
              },
              child: Text(
                'Start Simulation',
                 style: AppTextStyles.button(context).copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
