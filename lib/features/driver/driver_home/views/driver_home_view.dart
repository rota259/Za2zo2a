import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../features/map/domain/usecases/get_user_location_use_case.dart';
import '../../../../features/map/presentation/view/map_view.dart';
import '../../../../features/map/presentation/viewmodel/map_cubit.dart';
import '../../../../features/home/views/widgets/map_floating_button.dart';
import '../../../../injection_container.dart';
import '../../dispatch/driver_dispatch_cubit.dart';
import '../../dispatch/driver_dispatch_state.dart';
import '../../data/driver_repo.dart';
import '../widgets/driver_top_app_bar.dart';
import '../widgets/driver_stats_row.dart';
import '../widgets/driver_bonus_card.dart';
import '../widgets/driver_offline_button.dart';
import '../widgets/driver_available_trips.dart';
import '../widgets/driver_bottom_nav.dart';
import '../widgets/driver_history_panel.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView>
    with WidgetsBindingObserver {
  late final MapCubit _mapCubit;

  int _totalTrips = 0;
  String _onlineTime = '--';
  double _acceptanceRate = 0;
  bool _statsLoading = false;

  // 0 = HOME, 2 = HISTORY (matching nav indices)
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initLocation();
    _fetchTodayStats();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _mapCubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<DriverDispatchCubit>();
    if (state == AppLifecycleState.resumed) {
      cubit.resume();
      _fetchTodayStats();
    } else {
      cubit.pause();
    }
  }

  Future<void> _fetchTodayStats() async {
    if (_statsLoading) return;
    _statsLoading = true;
    final repo = sl<DriverRepo>();
    try {
      final stats = await repo.getStats();
      if (!mounted) return;
      setState(() {
        _totalTrips = stats.totalTrips;
        final hours = stats.onlineHours;
        _onlineTime = hours > 0 ? '${hours.toStringAsFixed(1)}h' : '--';
        _acceptanceRate = stats.acceptanceRate;
      });
    } on ApiError {
      // best-effort
    } finally {
      _statsLoading = false;
    }
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
    return BlocConsumer<DriverDispatchCubit, DriverDispatchState>(
      listener: (context, state) {
        if (state.acceptedTrip != null) {
          final id = state.acceptedTrip!.id;
          context.read<DriverDispatchCubit>().consumeAccepted();
          context.push('/driver/trip/$id').then((_) => _fetchTodayStats());
        }
        if (state.message != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      builder: (context, state) {
        final isOnline = state.isOnline;
        final hasTrips = state.isOnline && state.trips.isNotEmpty;

        Widget body;
        if (_activeTab == 2) {
          body = const DriverHistoryPanel();
        } else if (hasTrips) {
          body = const DriverAvailableTrips();
        } else {
          body = BlocProvider.value(
            value: _mapCubit,
            child: _buildOfflineOrWaitingView(context, state, isOnline),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.grey100,
          body: body,
          bottomNavigationBar: DriverBottomNav(
            activeIndex: _activeTab,
            onTabChanged: (i) => setState(() => _activeTab = i),
          ),
        );
      },
    );
  }

  Widget _buildOfflineOrWaitingView(
    BuildContext context,
    DriverDispatchState state,
    bool isOnline,
  ) {
    return Stack(
      children: [
        const Positioned.fill(child: MapView.embedded()),
        Center(
          child: Container(
            width: context.widthPct(40),
            height: context.widthPct(40),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                DriverTopAppBar(isOnline: isOnline),
                DriverStatsRow(
                  totalTrips: _totalTrips,
                  onlineTime: _onlineTime,
                  acceptanceRate: _acceptanceRate,
                ),
                SizedBox(height: context.heightPct(16)),
                const DriverBonusCard(),
                if (isOnline) ...[
                  SizedBox(height: context.heightPct(16)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.widthPct(16)),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.local_taxi, color: Colors.white),
                        label: Text(
                          state.loadingTrips ? 'Checking…' : 'Available Trips',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                              vertical: context.heightPct(14)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: state.loadingTrips
                            ? null
                            : () =>
                                context.read<DriverDispatchCubit>().goOnline(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        Positioned(
          bottom: context.heightPct(100),
          right: context.widthPct(16),
          child: MapFloatingButton(
            icon: Icons.gps_fixed,
            onTap: () => _onGpsTap(state.driverLocation),
          ),
        ),
        DriverOfflineButton(isOnline: isOnline),
      ],
    );
  }
}
