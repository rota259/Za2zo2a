import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';

class DriverBonusCard extends StatelessWidget {
  const DriverBonusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
      child: Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.widthPct(16)),
          border: Border.all(color: Colors.orange.shade200),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Colors.orange,
                  size: context.widthPct(16),
                ),
                SizedBox(width: context.widthPct(6)),
                Text(
                  'TODAY\'S BONUS',
                  style: AppTextStyles.caption(context).copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '+\$10 for 5 more rides',
                  style: AppTextStyles.h3(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(context.widthPct(6)),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.flash_on,
                    color: Colors.orange,
                    size: context.widthPct(16),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(12)),
            Text(
              '3/5 COMPLETED',
              style: AppTextStyles.caption(context).copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.heightPct(6)),
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: AppColors.grey200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      ),
    );
  }
}
