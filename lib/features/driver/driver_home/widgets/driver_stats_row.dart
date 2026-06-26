import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';

class DriverStatsRow extends StatelessWidget {
  final int totalTrips;
  final String onlineTime;
  final double acceptanceRate;

  const DriverStatsRow({
    super.key,
    this.totalTrips = 0,
    this.onlineTime = '--',
    this.acceptanceRate = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
      child: Row(
        children: [
          _TopStatBox(title: 'TRIPS', value: '$totalTrips'),
          SizedBox(width: context.widthPct(8)),
          _TopStatBox(title: 'ONLINE', value: onlineTime),
          SizedBox(width: context.widthPct(8)),
          _TopStatBox(
            title: 'ACCEPT %',
            value: '${acceptanceRate.toStringAsFixed(0)}%',
          ),
        ],
      ),
    );
  }
}

class _TopStatBox extends StatelessWidget {
  final String title;
  final String value;

  const _TopStatBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.heightPct(12),
          horizontal: context.widthPct(8),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: context.fontPct(10),
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: context.heightPct(4)),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                style: AppTextStyles.h3(
                  context,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
