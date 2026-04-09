import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';

class DriverTopAppBar extends StatelessWidget {
  final bool isOnline;

  const DriverTopAppBar({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(16),
        vertical: context.heightPct(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: context.widthPct(18),
            backgroundColor: Colors.blueGrey.shade800,
            child: Icon(
              Icons.person,
              color: Colors.amber.shade200,
              size: context.widthPct(20),
            ),
          ),
          SizedBox(width: context.widthPct(12)),
          Text(
            'VoltRide',
            style: AppTextStyles.h2(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: context.fontPct(22),
            ),
          ),
          const Spacer(),
          if (isOnline)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(12),
                vertical: context.heightPct(6),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(context.widthPct(20)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sensors,
                    color: AppColors.primary,
                    size: context.widthPct(14),
                  ),
                  SizedBox(width: context.widthPct(4)),
                  Text(
                    'ONLINE',
                    style: AppTextStyles.caption(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            Icon(Icons.sensors_off, color: AppColors.grey500),
        ],
      ),
    );
  }
}
