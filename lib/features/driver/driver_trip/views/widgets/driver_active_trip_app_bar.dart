import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';

class DriverActiveTripAppBar extends StatelessWidget {
  const DriverActiveTripAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
        color: Colors.white,
        child: Row(
          children: [
            CircleAvatar(
              radius: context.widthPct(16),
              backgroundColor: Colors.blueGrey.shade800,
              child: Icon(
                Icons.person,
                color: Colors.amber.shade200,
                size: context.widthPct(18),
              ),
            ),
            SizedBox(width: context.widthPct(12)),
            Text(
              'VoltRide',
              style: AppTextStyles.h2(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: context.fontPct(18),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'LIVE CONNECTION',
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
                  '5G Ultra Wide',
                  style: TextStyle(fontSize: 8, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
