import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';

class ActiveTripNextTurn extends StatelessWidget {
  const ActiveTripNextTurn({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.heightPct(100),
      left: context.widthPct(24),
      right: context.widthPct(24),
      child: Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.turn_left,
              color: AppColors.primary,
              size: context.widthPct(30),
            ),
            SizedBox(width: context.widthPct(16)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEXT TURN',
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'Turn left on Michigan Ave',
                  style: AppTextStyles.bodyLarge(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
