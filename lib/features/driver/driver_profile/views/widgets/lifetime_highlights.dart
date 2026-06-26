import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../data/models/driver_model.dart';

class LifetimeHighlights extends StatelessWidget {
  final DriverModel profile;

  const LifetimeHighlights({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.widthPct(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lifetime Highlights',
            style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: context.heightPct(12)),
          _HighlightRow(
            icon: Icons.thumb_up_outlined,
            label: 'Rating',
            value: profile.rating > 0
                ? profile.rating.toStringAsFixed(1)
                : '—',
          ),
          SizedBox(height: context.heightPct(8)),
          _HighlightRow(
            icon: Icons.access_time,
            label: 'Online Duration',
            value: profile.onlineFor.isNotEmpty ? profile.onlineFor : '—',
          ),
        ],
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HighlightRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(context.widthPct(8)),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: context.widthPct(16),
          ),
        ),
        SizedBox(width: context.widthPct(12)),
        Text(label, style: AppTextStyles.bodyMedium(context)),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.bodyMedium(context)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
