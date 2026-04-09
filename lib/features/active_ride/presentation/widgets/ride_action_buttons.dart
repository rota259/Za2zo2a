import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class RideActionButtons extends StatelessWidget {
  final VoidCallback onShareStatus;
  final VoidCallback onEmergency;

  const RideActionButtons({
    super.key,
    required this.onShareStatus,
    required this.onEmergency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onShareStatus,
            icon: const Icon(Icons.share_outlined),
            label: const Text(AppStrings.shareStatus),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onEmergency,
            icon: Icon(Icons.location_on, color: AppColors.primary),
            label: const Text(AppStrings.emergencySos),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.sosBg,
              foregroundColor: AppColors.primary,
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
