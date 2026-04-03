import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';

class DriverActiveTripControls extends StatelessWidget {
  final VoidCallback onLocationPressed;

  const DriverActiveTripControls({super.key, required this.onLocationPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: context.widthPct(16),
      bottom: context.heightPct(240),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {},
            ),
          ),
          SizedBox(height: context.heightPct(8)),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: IconButton(
              icon: const Icon(Icons.remove, color: Colors.black),
              onPressed: () {},
            ),
          ),
          SizedBox(height: context.heightPct(16)),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 8),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.my_location, color: Colors.white),
              onPressed: onLocationPressed,
            ),
          ),
        ],
      ),
    );
  }
}
