import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/ride_cubit.dart';
import '../cubit/ride_state.dart';

class ActiveTripView extends StatelessWidget {
  const ActiveTripView({super.key});

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
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final ride = state.activeRide;

        return Scaffold(
          body: Stack(
            children: [
              // 1. Background Map Layer (Mocked)
              Container(
                color: AppColors.grey200,
                child: Image.network(
                  'https://maps.googleapis.com/maps/api/staticmap?center=Chicago,IL&zoom=13&size=600x800&maptype=roadmap&key=mock',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(Icons.map, size: context.widthPct(100), color: AppColors.grey400),
                  ),
                ),
              ),

              // 2. Custom Floating App Bar
              Positioned(
                top: context.heightPct(40),
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: context.widthPct(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: AppColors.primary),
                        onPressed: () {
                          context.read<RideCubit>().cancelRide();
                        },
                      ),
                      Text('Ride in Progress', style: AppTextStyles.h2(context).copyWith(fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: AppColors.primary),
                        onPressed: () {
                          // Tap to definitively end trip
                          context.read<RideCubit>().endTrip(ride);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Floating Next Turn Navigation Card
              Positioned(
                top: context.heightPct(100),
                left: context.widthPct(24),
                right: context.widthPct(24),
                child: Container(
                  padding: EdgeInsets.all(context.widthPct(16)),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(context.widthPct(12)),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.turn_left, color: AppColors.primary, size: context.widthPct(30)),
                      SizedBox(width: context.widthPct(16)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NEXT TURN', style: AppTextStyles.bodySmall(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                          Text('Turn left on Michigan Ave', style: AppTextStyles.bodyLarge(context).copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 4. Floating Map Controls (Right edge)
              Positioned(
                right: context.widthPct(16),
                top: context.heightPct(200),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(context.widthPct(8)),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                      ),
                      child: Column(
                        children: [
                          IconButton(icon: Icon(Icons.add, color: AppColors.textPrimary), onPressed: () {}),
                          Container(height: 1, width: 24, color: AppColors.grey200),
                          IconButton(icon: Icon(Icons.remove, color: AppColors.textPrimary), onPressed: () {}),
                        ],
                      ),
                    ),
                    SizedBox(height: context.heightPct(16)),
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: AppColors.primary,
                      elevation: 4,
                      onPressed: () {},
                      child: const Icon(Icons.my_location, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // 5. Sliding Bottom Sheet with Ride Details
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.fromLTRB(context.widthPct(24), context.heightPct(16), context.widthPct(24), context.heightPct(24)),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.widthPct(24)),
                      topRight: Radius.circular(context.widthPct(24)),
                    ),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Notch
                      Center(
                        child: Container(
                          width: context.widthPct(40),
                          height: 4,
                          decoration: BoxDecoration(color: AppColors.grey300, borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // Time & Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('8 mins', style: AppTextStyles.h1(context).copyWith(color: AppColors.primary, fontSize: context.fontPct(28))),
                              Text('Arriving at 4:25 PM • 2.4 km', style: AppTextStyles.bodyMedium(context).copyWith(color: AppColors.textSecondary)),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.primary.withOpacity(0.1),
                                radius: context.widthPct(24),
                                child: Icon(Icons.call, color: AppColors.primary),
                              ),
                              SizedBox(width: context.widthPct(12)),
                              CircleAvatar(
                                backgroundColor: AppColors.primary,
                                radius: context.widthPct(24),
                                child: const Icon(Icons.chat_bubble, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // Custom Progress Route Bar
                      Stack(
                        children: [
                          Container(height: 6, width: double.infinity, decoration: BoxDecoration(color: AppColors.grey200, borderRadius: BorderRadius.circular(3))),
                          Container(height: 6, width: context.widthPct(220), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(3))),
                        ],
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // Driver Grey Container Info Box
                      Container(
                        padding: EdgeInsets.all(context.widthPct(16)),
                        decoration: BoxDecoration(
                          color: AppColors.grey50,
                          borderRadius: BorderRadius.circular(context.widthPct(12)),
                        ),
                        child: Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: context.widthPct(24),
                                  backgroundColor: const Color(0xFF2C3E50),
                                  child: Icon(Icons.person, color: const Color(0xFFE5CC98), size: context.widthPct(30)),
                                ),
                                Positioned(
                                  bottom: -8,
                                  left: 4,
                                  right: 4,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(ride.driverRating.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                        const Icon(Icons.star, color: Colors.white, size: 8),
                                      ],
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
                                  Text(ride.driverName, style: AppTextStyles.h3(context)),
                                  Text(ride.title, style: AppTextStyles.bodySmall(context)),
                                  Text(ride.licensePlate, style: AppTextStyles.bodySmall(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              width: context.widthPct(60),
                              height: context.heightPct(40),
                              decoration: BoxDecoration(
                                color: AppColors.grey200,
                                borderRadius: BorderRadius.circular(context.widthPct(8)),
                              ),
                              child: Icon(Icons.directions_car, color: AppColors.grey500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // Action Buttons Row (Share / SOS)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.grey200),
                                padding: EdgeInsets.symmetric(vertical: context.heightPct(16)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.widthPct(12))),
                              ),
                              icon: Icon(Icons.share, color: AppColors.primary),
                              label: Text('Share\nStatus', textAlign: TextAlign.center, style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: context.widthPct(16)),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary.withOpacity(0.1),
                                elevation: 0,
                                padding: EdgeInsets.symmetric(vertical: context.heightPct(16)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.widthPct(12))),
                              ),
                              icon: Icon(Icons.cell_tower, color: AppColors.primary),
                              label: Text('Emergency\nSOS', textAlign: TextAlign.center, style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
