import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class QuickChipsRow extends StatelessWidget {
  final ValueChanged<String> onSelected;

  const QuickChipsRow({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final chips = [
      (Icons.home_outlined, AppStrings.home),
      (Icons.work_outline, AppStrings.work),
      (Icons.history, AppStrings.recent),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips
            .map(
              (chip) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  onPressed: () => onSelected(chip.$2),
                  avatar: Icon(chip.$1, size: 18, color: AppColors.greyText),
                  label: Text(chip.$2),
                  side: BorderSide(color: AppColors.grey300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
