import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/ride_model.dart';

class ActiveTripDetailsSheet extends StatelessWidget {
  final RideModel ride;

  const ActiveTripDetailsSheet({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.widthPct(24),
          context.heightPct(16),
          context.widthPct(24),
          context.heightPct(24),
        ),
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
            Center(
              child: Container(
                width: context.widthPct(40),
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.heightPct(24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '8 mins',
                      style: AppTextStyles.h1(context).copyWith(
                        color: AppColors.primary,
                        fontSize: context.fontPct(28),
                      ),
                    ),
                    Text(
                      'Arriving at 4:25 PM • 2.4 km',
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
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
            Stack(
              children: [
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grey200,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Container(
                  height: 6,
                  width: context.widthPct(220),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(24)),
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
                        child: Icon(
                          Icons.person,
                          color: const Color(0xFFE5CC98),
                          size: context.widthPct(30),
                        ),
                      ),
                      Positioned(
                        bottom: -8,
                        left: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ride.driverRating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 8,
                              ),
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
                        Text(
                          ride.title,
                          style: AppTextStyles.bodySmall(context),
                        ),
                        Text(
                          ride.licensePlate,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.grey200),
                      padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.widthPct(12),
                        ),
                      ),
                    ),
                    icon: Icon(Icons.share, color: AppColors.primary),
                    label: Text(
                      'Share\nStatus',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: context.widthPct(16)),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.widthPct(12),
                        ),
                      ),
                    ),
                    icon: Icon(Icons.cell_tower, color: AppColors.primary),
                    label: Text(
                      'Emergency\nSOS',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
