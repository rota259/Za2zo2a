import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import 'map_floating_button.dart';

class HomeTopBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback onGpsTap;

  const HomeTopBar({
    super.key,
    required this.scaffoldKey,
    required this.onGpsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.heightPct(50),
      left: context.widthPct(16),
      right: context.widthPct(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => scaffoldKey.currentState?.openDrawer(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(14),
                vertical: context.heightPct(10),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(context.widthPct(10)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: context.widthPct(20),
                  ),
                  SizedBox(width: context.widthPct(8)),
                  Text(
                    'Za2zo2a',
                    style: AppTextStyles.bodyLarge(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          MapFloatingButton(
            icon: Icons.notifications_none_outlined,
            onTap: () {},
          ),
          SizedBox(width: context.widthPct(8)),
          MapFloatingButton(icon: Icons.gps_fixed, onTap: onGpsTap),
          SizedBox(width: context.widthPct(8)),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(12),
                vertical: context.heightPct(10),
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(context.widthPct(10)),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: AppColors.primary,
                    size: context.widthPct(18),
                  ),
                  SizedBox(width: context.widthPct(4)),
                  Text(
                    'Safety',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
