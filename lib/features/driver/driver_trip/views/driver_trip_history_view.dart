import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';
import '../data/models/driver_trip_model.dart';

class DriverTripHistoryView extends StatefulWidget {
  const DriverTripHistoryView({super.key});

  @override
  State<DriverTripHistoryView> createState() => _DriverTripHistoryViewState();
}

class _DriverTripHistoryViewState extends State<DriverTripHistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<DriverTripCubit>().loadTripHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/driver/home'),
        ),
        title: Text('Trip History', style: AppTextStyles.h2(context)),
        centerTitle: true,
      ),
      body: BlocBuilder<DriverTripCubit, DriverTripState>(
        builder: (context, state) {
          if (state is DriverTripLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            );
          }

          if (state is DriverTripError) {
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
                  Text(
                    state.message,
                    style: AppTextStyles.bodyMedium(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is! DriverTripHistoryLoaded || state.trips.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: context.widthPct(70),
                    color: AppColors.grey300,
                  ),
                  SizedBox(height: context.heightPct(16)),
                  Text(
                    'No trips yet',
                    style: AppTextStyles.h3(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: context.heightPct(8)),
                  Text(
                    'Your completed trips will appear here.',
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            );
          }

          final trips = state.trips;
          // Group trips by date
          final Map<String, List<DriverTripModel>> grouped = {};
          for (final t in trips) {
            final key = _formatDate(t.createdAt);
            grouped.putIfAbsent(key, () => []).add(t);
          }

          return Column(
            children: [
              // ── Summary Banner
              Container(
                margin: EdgeInsets.fromLTRB(
                  context.widthPct(16),
                  context.heightPct(8),
                  context.widthPct(16),
                  context.heightPct(16),
                ),
                padding: EdgeInsets.all(context.widthPct(16)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, const Color(0xFFB71C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(context.widthPct(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _BannerStat(value: '${trips.length}', label: 'Total Trips'),
                    Container(
                      width: 1,
                      height: context.heightPct(36),
                      color: Colors.white24,
                    ),
                    _BannerStat(
                      value:
                          'EGP ${trips.fold(0.0, (s, t) => s + t.fare).toStringAsFixed(0)}',
                      label: 'Total Earned',
                    ),
                    Container(
                      width: 1,
                      height: context.heightPct(36),
                      color: Colors.white24,
                    ),
                    _BannerStat(
                      value:
                          '${trips.fold(0.0, (s, t) => s + t.distanceKm).toStringAsFixed(1)} km',
                      label: 'Total Distance',
                    ),
                  ],
                ),
              ),

              // ── List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(16),
                  ),
                  itemCount: grouped.keys.length,
                  itemBuilder: (context, groupIdx) {
                    final dateKey = grouped.keys.elementAt(groupIdx);
                    final dayTrips = grouped[dateKey]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.heightPct(12),
                          ),
                          child: Text(
                            dateKey,
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        ...dayTrips.map((trip) => _TripCard(trip: trip)),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _BannerStat extends StatelessWidget {
  final String value;
  final String label;
  const _BannerStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.bodyLarge(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: AppTextStyles.caption(context).copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

class _TripCard extends StatelessWidget {
  final DriverTripModel trip;
  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(12)),
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(context.widthPct(14)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: context.widthPct(20),
                backgroundColor: AppColors.grey200,
                child: Icon(
                  Icons.person,
                  color: AppColors.grey500,
                  size: context.widthPct(22),
                ),
              ),
              SizedBox(width: context.widthPct(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.riderName,
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: context.widthPct(12),
                        ),
                        SizedBox(width: context.widthPct(2)),
                        Text(
                          trip.riderRating.toStringAsFixed(1),
                          style: AppTextStyles.caption(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'EGP ${trip.fare.toStringAsFixed(0)}',
                    style: AppTextStyles.bodyLarge(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: context.heightPct(3)),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(8),
                      vertical: context.heightPct(2),
                    ),
                    decoration: BoxDecoration(
                      color: trip.paymentMethod == 'cash'
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(context.widthPct(20)),
                    ),
                    child: Text(
                      trip.paymentMethod == 'cash' ? 'Cash' : 'Card',
                      style: AppTextStyles.caption(context).copyWith(
                        color: trip.paymentMethod == 'cash'
                            ? AppColors.success
                            : AppColors.info,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: context.heightPct(12)),
          Container(height: 1, color: AppColors.grey200),
          SizedBox(height: context.heightPct(12)),
          Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: AppColors.success,
                size: context.widthPct(14),
              ),
              SizedBox(width: context.widthPct(6)),
              Expanded(
                child: Text(
                  trip.pickupAddress,
                  style: AppTextStyles.bodySmall(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(4)),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.error,
                size: context.widthPct(14),
              ),
              SizedBox(width: context.widthPct(6)),
              Expanded(
                child: Text(
                  trip.destinationAddress,
                  style: AppTextStyles.bodySmall(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TripChip(
                icon: Icons.route,
                label: '${trip.distanceKm.toStringAsFixed(1)} km',
              ),
              _TripChip(
                icon: Icons.timer_outlined,
                label: '${trip.durationMinutes} min',
              ),
              _TripChip(
                icon: Icons.directions_car_outlined,
                label: trip.rideType,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TripChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _TripChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: context.widthPct(14), color: AppColors.grey500),
        SizedBox(width: context.widthPct(4)),
        Text(
          label,
          style: AppTextStyles.caption(
            context,
          ).copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
