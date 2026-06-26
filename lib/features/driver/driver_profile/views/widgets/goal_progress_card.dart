import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../data/models/driver_model.dart';

class GoalProgressCard extends StatelessWidget {
  final DriverModel profile;

  const GoalProgressCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final progress = profile.goalProgress;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = context.widthPct(40);
    final barMaxWidth = screenWidth - horizontalPadding;

    return Container(
      padding: EdgeInsets.all(context.widthPct(20)),
      decoration: BoxDecoration(
        color: const Color(0xFF151D29),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRIP GOAL',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: context.heightPct(8)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${profile.goalProgressPercent}%',
                style: AppTextStyles.h1(context).copyWith(
                  color: const Color(0xFFE91E63),
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                ' · ${profile.completedTrips} / ${profile.targetTrips} trips',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(12)),
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Container(
                height: 6,
                width: barMaxWidth * progress,
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
