import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class ActiveTripMapControls extends StatelessWidget {
  final VoidCallback onLocationPressed;

  const ActiveTripMapControls({super.key, required this.onLocationPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: context.widthPct(16),
      top: context.heightPct(200),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(context.widthPct(8)),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8),
              ],
            ),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: AppColors.textPrimary),
                  onPressed: () {},
                ),
                Container(height: 1, width: 24, color: AppColors.grey200),
                IconButton(
                  icon: Icon(Icons.remove, color: AppColors.textPrimary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: context.heightPct(16)),
          FloatingActionButton(
            mini: true,
            backgroundColor: AppColors.primary,
            elevation: 4,
            onPressed: onLocationPressed,
            child: const Icon(Icons.my_location, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
