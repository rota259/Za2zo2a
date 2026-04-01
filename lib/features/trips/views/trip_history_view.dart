import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/trips_cubit.dart';
import '../cubit/trips_state.dart';

class TripHistoryView extends StatefulWidget {
  const TripHistoryView({super.key});

  @override
  State<TripHistoryView> createState() => _TripHistoryViewState();
}

class _TripHistoryViewState extends State<TripHistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<TripsCubit>().loadTrips();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          onPressed: () => context.pop(),
        ),
        title: Text('Ride History', style: AppTextStyles.h2(context)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Driver profile mini card
          Container(
            margin: EdgeInsets.fromLTRB(
              context.widthPct(16),
              context.heightPct(8),
              context.widthPct(16),
              context.heightPct(16),
            ),
            padding: EdgeInsets.all(context.widthPct(16)),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(context.widthPct(12)),
              boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: context.widthPct(28),
                      backgroundColor: const Color(0xFF3D2B1F),
                      child: Icon(Icons.person, color: const Color(0xFFE5CC98), size: context.widthPct(30)),
                    ),
                    Positioned(
                      bottom: -4,
                      left: 6,
                      right: 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'GOLD',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: context.fontPct(9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: context.widthPct(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Marcus Thompson',
                          style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(height: context.heightPct(4)),
                      Row(
                        children: [
                          Icon(Icons.star, color: AppColors.warning, size: context.fontPct(14)),
                          SizedBox(width: context.widthPct(4)),
                          Text('4.9 Rating',
                              style: AppTextStyles.bodySmall(context)
                                  .copyWith(color: AppColors.textSecondary)),
                          Text(' • Member since 2022',
                              style: AppTextStyles.bodySmall(context)
                                  .copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 2.5,
              labelStyle: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'All Rides'),
                Tab(text: 'Personal'),
                Tab(text: 'Business'),
              ],
            ),
          ),

          // ── Trip List
          Expanded(
            child: BlocBuilder<TripsCubit, TripsState>(
              builder: (context, state) {
                if (state is TripsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TripsError) {
                  return Center(child: Text(state.message));
                }
                if (state is TripsLoaded) {
                  final trips = state.trips;
                  if (trips.isEmpty) {
                    return Center(
                        child: Text('No recent trips', style: AppTextStyles.bodyLarge(context)));
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      context.widthPct(16),
                      context.heightPct(16),
                      context.widthPct(16),
                      context.heightPct(80),
                    ),
                    itemCount: trips.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: context.heightPct(12)),
                          child: Text('Recent Trips',
                              style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.bold)),
                        );
                      }
                      final trip = trips[index - 1];
                      final isCompleted = trip.status == 'Completed';
                      return _TripCard(trip: trip, isCompleted: isCompleted);
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final dynamic trip;
  final bool isCompleted;

  const _TripCard({required this.trip, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(16)),
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(context.widthPct(12)),
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: date + price + status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${trip.date}, ${trip.time}',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: context.heightPct(4)),
                  Text('Trip',
                      style: AppTextStyles.bodyLarge(context).copyWith(fontWeight: FontWeight.bold)),
                  Text('EV-0000-XX',
                      style: AppTextStyles.bodySmall(context).copyWith(color: AppColors.textSecondary)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$${trip.price.toStringAsFixed(2)}',
                      style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: context.heightPct(4)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(8),
                      vertical: context.heightPct(4),
                    ),
                    decoration: BoxDecoration(
                      color: isCompleted ? AppColors.success : AppColors.error,
                      borderRadius: BorderRadius.circular(context.widthPct(4)),
                    ),
                    child: Text(
                      trip.status,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: context.fontPct(11),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: context.heightPct(16)),

          // ── Route
          Row(
            children: [
              Column(
                children: [
                  Icon(Icons.circle, color: AppColors.primary, size: context.fontPct(10)),
                  Container(
                      width: 2, height: context.heightPct(28), color: AppColors.grey300),
                  Icon(Icons.location_on, color: AppColors.grey500, size: context.fontPct(12)),
                ],
              ),
              SizedBox(width: context.widthPct(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LocationText(label: 'Pickup', value: trip.pickup, context: context),
                    SizedBox(height: context.heightPct(16)),
                    _LocationText(label: 'Drop-off', value: trip.dropoff, context: context),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: context.heightPct(16)),

          // ── Stats: distance, time, energy
          Row(
            children: [
              _TripStat(icon: Icons.straighten, value: '— km', context: context),
              SizedBox(width: context.widthPct(16)),
              _TripStat(icon: Icons.timer_outlined, value: '— mins', context: context),
              SizedBox(width: context.widthPct(16)),
              _TripStat(icon: Icons.bolt, value: '— kWh', context: context),
            ],
          ),
        ],
      ),
    );
  }
}

class _LocationText extends StatelessWidget {
  final String label;
  final String value;
  final BuildContext context;

  const _LocationText({required this.label, required this.value, required this.context});

  @override
  Widget build(BuildContext outerContext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySmall(context).copyWith(color: AppColors.textSecondary)),
        Text(value, style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _TripStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final BuildContext context;

  const _TripStat({required this.icon, required this.value, required this.context});

  @override
  Widget build(BuildContext _) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: context.fontPct(14)),
        SizedBox(width: context.widthPct(4)),
        Text(value, style: AppTextStyles.bodySmall(context).copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}
