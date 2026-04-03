import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class MapFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MapFloatingButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.widthPct(10)),
        decoration: BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Icon(
          icon,
          size: context.widthPct(20),
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
