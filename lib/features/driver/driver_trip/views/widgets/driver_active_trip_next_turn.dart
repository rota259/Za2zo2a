import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';

class DriverActiveTripNextTurn extends StatelessWidget {
  const DriverActiveTripNextTurn({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.heightPct(90),
      left: context.widthPct(16),
      right: context.widthPct(16),
      child: Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.widthPct(10)),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(context.widthPct(8)),
              ),
              child: Icon(
                Icons.turn_right_rounded,
                color: Colors.white,
                size: context.widthPct(24),
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
                        '450 ',
                        style: AppTextStyles.h2(
                          context,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'METERS',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Turn Right onto\nMarket Street',
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(height: 1.2, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'ETA',
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '4 min',
                  style: AppTextStyles.h2(
                    context,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
