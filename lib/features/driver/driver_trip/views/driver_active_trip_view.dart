import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';

class DriverActiveTripView extends StatelessWidget {
  const DriverActiveTripView({super.key});

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
          backgroundColor: const Color(0xFF1C2B39), // Dark Map Background
          body: Stack(
            children: [
              // ── Placeholder Map Background
              Positioned.fill(
                child: CustomPaint(painter: _DarkMapGridPainter()),
              ),
              
              // ── Top Bar Container Over Map
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(context.widthPct(16), context.heightPct(40), context.widthPct(16), context.heightPct(12)),
                  color: Colors.white,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: context.widthPct(16),
                        backgroundColor: Colors.blueGrey.shade800,
                        child: Icon(Icons.person, color: Colors.amber.shade200, size: context.widthPct(18)),
                      ),
                      SizedBox(width: context.widthPct(12)),
                      Text(
                        'VoltRide',
                        style: AppTextStyles.h2(context).copyWith(fontWeight: FontWeight.bold, fontSize: context.fontPct(18)),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text('LIVE CONNECTION', style: TextStyle(fontSize: 8, color: AppColors.primary, fontWeight: FontWeight.bold)),
                              SizedBox(width: 4),
                              Icon(Icons.sensors, color: AppColors.primary, size: 12),
                            ],
                          ),
                          Text('5G Ultra Wide', style: TextStyle(fontSize: 8, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ── Next Turn Card
              Positioned(
                top: context.heightPct(90),
                left: context.widthPct(16),
                right: context.widthPct(16),
                child: Container(
                  padding: EdgeInsets.all(context.widthPct(16)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(context.widthPct(12)),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.widthPct(10)),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(context.widthPct(8)),
                        ),
                        child: Icon(Icons.turn_right_rounded, color: Colors.white, size: context.widthPct(24)),
                      ),
                      SizedBox(width: context.widthPct(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('450 ', style: AppTextStyles.h2(context).copyWith(fontWeight: FontWeight.w900)),
                                Text('METERS', style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text('Turn Right onto\nMarket Street', style: AppTextStyles.bodyMedium(context).copyWith(height: 1.2, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('ETA', style: TextStyle(fontSize: 9, color: AppColors.primary, fontWeight: FontWeight.bold)),
                          Text('4 min', style: AppTextStyles.h2(context).copyWith(fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ── Right Controls
              Positioned(
                right: context.widthPct(16),
                bottom: context.heightPct(240),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                      ),
                      child: IconButton(icon: Icon(Icons.add, color: Colors.black), onPressed: () {}),
                    ),
                    SizedBox(height: context.heightPct(8)),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                      ),
                      child: IconButton(icon: Icon(Icons.remove, color: Colors.black), onPressed: () {}),
                    ),
                    SizedBox(height: context.heightPct(16)),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.my_location, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              // ── Bottom Sheet
              Positioned(
                bottom: context.heightPct(12),
                left: context.widthPct(12),
                right: context.widthPct(12),
                child: Container(
                  padding: EdgeInsets.all(context.widthPct(16)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(context.widthPct(16)),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CURRENT DESTINATION', style: TextStyle(fontSize: 9, color: AppColors.textSecondary, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                SizedBox(height: 4),
                                Text('Pier 39, Beach St', style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.w900, fontSize: 18)),
                                Text('San Francisco, CA 94133', style: AppTextStyles.bodySmall(context).copyWith(color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: context.widthPct(10), vertical: context.heightPct(6)),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text('CONSTANT PRICE', style: TextStyle(fontSize: 8, color: AppColors.primary, fontWeight: FontWeight.bold)),
                                Text('\$24.50', style: AppTextStyles.h3(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(24)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: AppColors.primary, size: 16),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('DISTANCE', style: TextStyle(fontSize: 8, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                                  Text('2.8 km', style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: AppColors.primary, size: 16),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('TRIP TIME', style: TextStyle(fontSize: 8, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                                  Text('12:04', style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(24)),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF900020), // Dark red exactly like image
                            padding: EdgeInsets.symmetric(vertical: context.heightPct(14)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                              Icon(Icons.stop_circle_outlined, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                isHeadingToPickup ? 'ARRIVED' : 'END TRIP',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1.2, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
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

class _DarkMapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()..color = const Color(0xFF4A5C6B); // Gridded blue/grey color
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    Paint gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 0.5;
    for (double i = 0; i < size.width; i += 20) canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    for (double j = 0; j < size.height; j += 20) canvas.drawLine(Offset(0, j), Offset(size.width, j), gridPaint);

    // Cyan glowing lines
    Paint pathPaint = Paint()
      ..color = Colors.cyanAccent.shade400
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.square;
    
    // Draw thick cyan map lines mimicking specific routes
    canvas.drawLine(Offset(0, size.height * 0.35), Offset(size.width * 0.6, size.height * 0.35), pathPaint);
    canvas.drawLine(Offset(size.width * 0.6, 0), Offset(size.width * 0.6, size.height), pathPaint);
    canvas.drawLine(Offset(0, size.height * 0.70), Offset(size.width, size.height * 0.70), pathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
