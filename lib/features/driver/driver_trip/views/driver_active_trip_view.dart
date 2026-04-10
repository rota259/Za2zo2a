import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../active_ride/domain/entities/route_entity.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';
import '../data/models/driver_trip_model.dart';

class DriverActiveTripView extends StatefulWidget {
  const DriverActiveTripView({super.key});

  @override
  State<DriverActiveTripView> createState() => _DriverActiveTripViewState();
}

class _DriverActiveTripViewState extends State<DriverActiveTripView>
    with SingleTickerProviderStateMixin {
  final _mapController = MapController();
  double _zoom = AppConstants.initialMapZoom;
  String? _signature;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _fitRoute(RouteEntity route) {
    final signature =
        '${route.origin}_${route.destination}_${route.points.length}';
    if (_signature == signature) return;
    _signature = signature;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _mapController.fitCamera(
        CameraFit.coordinates(
          coordinates: route.points.isEmpty
              ? [route.origin, route.destination]
              : route.points,
          padding: const EdgeInsets.fromLTRB(40, 120, 40, 320),
          maxZoom: AppConstants.maxZoom,
        ),
      );
    });
  }

  void _zoomBy(double delta) {
    final center = _mapController.camera.center;
    _zoom = (_zoom + delta).clamp(AppConstants.minZoom, AppConstants.maxZoom);
    _mapController.move(center, _zoom);
  }

  Future<void> _handleNavigation() async {
    final cubit = context.read<DriverTripCubit>();
    final launched = await cubit.navigateToTarget();
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.couldNotOpenMaps)),
      );
    }
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
        final RouteEntity? route;
        final DriverTripModel? trip;
        final String? turnInstruction;
        final String? distanceToTurn;
        final String? eta;

        if (state is DriverHeadingToPickup) {
          route = state.route;
          trip = state.trip;
          turnInstruction = state.turnInstruction;
          distanceToTurn = state.distanceToTurn;
          eta = state.eta;
        } else if (state is DriverTripInProgress) {
          route = state.route;
          trip = state.trip;
          turnInstruction = state.turnInstruction;
          distanceToTurn = state.distanceToTurn;
          eta = state.eta;
        } else {
          route = null;
          trip = null;
          turnInstruction = null;
          distanceToTurn = null;
          eta = null;
        }

        if (trip == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (route != null) {
          _fitRoute(route);
        }

        return Scaffold(
          backgroundColor: const Color(0xFF1C2B39),
          body: Stack(
            children: [
              // ── Map ──
              Positioned.fill(
                child: _buildMap(route),
              ),

              // ── Top Bar ──
              _buildTopBar(context, isHeadingToPickup),

              // ── Next Turn Card ──
              if (turnInstruction != null && distanceToTurn != null)
                _buildNextTurnCard(
                  context,
                  turnInstruction,
                  distanceToTurn,
                  eta ?? '',
                ),

              // ── Map Controls ──
              _buildMapControls(context, route),

              // ── Bottom Sheet ──
              _buildBottomSheet(
                context,
                trip,
                isHeadingToPickup,
                eta,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMap(RouteEntity? route) {
    final points = route?.points ?? [];
    final hasRoute = route != null && points.isNotEmpty;
    final center = hasRoute ? route.origin : const LatLng(30.0444, 31.2357);

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: AppConstants.initialMapZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: AppConstants.osmTileUrl,
          userAgentPackageName: AppConstants.tileUserAgentPackageName,
        ),
        if (hasRoute)
          PolylineLayer(
            polylines: [
              Polyline(
                points: points,
                strokeWidth: 5,
                color: AppColors.primary,
              ),
            ],
          ),
        if (hasRoute)
          MarkerLayer(
            markers: [
              Marker(
                point: route.origin,
                width: 44,
                height: 44,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.local_taxi,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Marker(
                point: route.destination,
                width: 44,
                height: 44,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkRed,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.flag_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context, bool isHeadingToPickup) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.widthPct(16),
          context.heightPct(40),
          context.widthPct(16),
          context.heightPct(12),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back, size: 20),
              ),
            ),
            SizedBox(width: context.widthPct(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VoltRide',
                    style: AppTextStyles.h2(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: context.fontPct(18),
                    ),
                  ),
                  const SizedBox(height: 2),
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isHeadingToPickup
                                  ? Colors.orange
                                  : AppColors.success,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: (isHeadingToPickup
                                          ? Colors.orange
                                          : AppColors.success)
                                      .withValues(
                                        alpha: _pulseController.value * 0.6,
                                      ),
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isHeadingToPickup
                                ? 'HEADING TO PICKUP'
                                : 'TRIP IN PROGRESS',
                            style: TextStyle(
                              fontSize: 10,
                              color: isHeadingToPickup
                                  ? Colors.orange.shade700
                                  : AppColors.success,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.liveConnection,
                      style: TextStyle(
                        fontSize: 8,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.sensors, color: AppColors.primary, size: 12),
                  ],
                ),
                const Text(
                  AppStrings.fiveGUltraWide,
                  style: TextStyle(fontSize: 8, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextTurnCard(
    BuildContext context,
    String turnInstruction,
    String distanceToTurn,
    String eta,
  ) {
    return Positioned(
      top: context.heightPct(100),
      left: context.widthPct(16),
      right: context.widthPct(16),
      child: Container(
        padding: EdgeInsets.all(context.widthPct(14)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.widthPct(14)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.widthPct(10)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.darkRed],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(context.widthPct(10)),
              ),
              child: Icon(
                Icons.turn_right_rounded,
                color: Colors.white,
                size: context.widthPct(22),
              ),
            ),
            SizedBox(width: context.widthPct(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        distanceToTurn,
                        style: AppTextStyles.h3(context)
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    turnInstruction,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.eta,
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    eta,
                    style: AppTextStyles.h3(context).copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControls(BuildContext context, RouteEntity? route) {
    return Positioned(
      right: context.widthPct(16),
      bottom: context.heightPct(310),
      child: Column(
        children: [
          _mapControlButton(
            heroTag: 'driver_active_zoom_in',
            icon: Icons.add,
            onPressed: () => _zoomBy(1),
            color: Colors.white,
            iconColor: Colors.black,
          ),
          SizedBox(height: context.heightPct(8)),
          _mapControlButton(
            heroTag: 'driver_active_zoom_out',
            icon: Icons.remove,
            onPressed: () => _zoomBy(-1),
            color: Colors.white,
            iconColor: Colors.black,
          ),
          SizedBox(height: context.heightPct(16)),
          _mapControlButton(
            heroTag: 'driver_active_center',
            icon: Icons.my_location,
            onPressed: () {
              if (route != null) {
                _signature = null;
                _fitRoute(route);
              }
            },
            color: AppColors.primary,
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _mapControlButton({
    required String heroTag,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildBottomSheet(
    BuildContext context,
    DriverTripModel trip,
    bool isHeadingToPickup,
    String? eta,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.widthPct(20),
          context.widthPct(20),
          context.widthPct(20),
          context.heightPct(24),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Drag Handle ──
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // ── Phase Label ──
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isHeadingToPickup
                      ? Colors.orange.shade50
                      : AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isHeadingToPickup
                          ? Icons.location_searching
                          : Icons.navigation_rounded,
                      size: 14,
                      color: isHeadingToPickup
                          ? Colors.orange.shade700
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isHeadingToPickup ? 'HEADING TO PICKUP' : 'IN TRIP',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: isHeadingToPickup
                            ? Colors.orange.shade700
                            : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Destination Info ──
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route indicators
                  Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 32,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primary,
                              AppColors.grey300,
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.location_on,
                        color: AppColors.darkRed,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHeadingToPickup ? 'PICKUP' : 'FROM',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          trip.pickupAddress,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'DESTINATION',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          trip.destinationAddress,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Price badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.constantPrice,
                          style: TextStyle(
                            fontSize: 8,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${AppStrings.currencySymbol}${trip.fare.toStringAsFixed(2)}',
                          style: AppTextStyles.h3(context).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Stats Row ──
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat(
                      Icons.location_on_outlined,
                      'DISTANCE',
                      '${trip.distanceKm.toStringAsFixed(1)} ${AppStrings.distanceUnitKm}',
                    ),
                    Container(width: 1, height: 30, color: AppColors.grey200),
                    _buildStat(
                      Icons.access_time,
                      'ETA',
                      eta ?? '${trip.durationMinutes} ${AppStrings.minuteShort}',
                    ),
                    Container(width: 1, height: 30, color: AppColors.grey200),
                    _buildStat(
                      Icons.person_outline,
                      'RIDER',
                      trip.riderName.split(' ').first,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Navigate Button ──
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _handleNavigation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.navigation_rounded, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.navigate,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ── Action Button ──
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isHeadingToPickup
                        ? AppColors.primary
                        : AppColors.darkRed,
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (isHeadingToPickup) {
                      context.read<DriverTripCubit>().startTrip();
                    } else {
                      context.read<DriverTripCubit>().completeTrip();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isHeadingToPickup
                            ? Icons.check_circle_outline
                            : Icons.stop_circle_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isHeadingToPickup
                            ? 'RIDER PICKED UP'
                            : AppStrings.endTrip,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 16),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
