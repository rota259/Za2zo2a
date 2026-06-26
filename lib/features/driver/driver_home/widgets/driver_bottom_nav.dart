import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';

class DriverBottomNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onTabChanged;

  const DriverBottomNav({
    super.key,
    this.activeIndex = 0,
    this.onTabChanged,
  });

  void _onTabTapped(BuildContext context, int index) {
    if (index == activeIndex) return;
    if (index == 0 || index == 2) {
      onTabChanged?.call(index);
      return;
    }
    if (index == 1) context.go('/driver/earnings');
    if (index == 3) context.go('/driver/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                icon: Icons.dashboard_outlined,
                label: 'HOME',
                isActive: activeIndex == 0,
                onTap: () => _onTabTapped(context, 0),
              ),
              _NavIcon(
                icon: Icons.account_balance_wallet_outlined,
                label: 'EARNINGS',
                onTap: () => _onTabTapped(context, 1),
              ),
              _NavIcon(
                icon: Icons.history,
                label: 'HISTORY',
                isActive: activeIndex == 2,
                onTap: () => _onTabTapped(context, 2),
              ),
              _NavIcon(
                icon: Icons.person_outline,
                label: 'PROFILE',
                onTap: () => _onTabTapped(context, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.grey400,
            size: context.widthPct(24),
          ),
          SizedBox(height: context.heightPct(4)),
          Text(
            label,
            style: TextStyle(
              fontSize: context.fontPct(9),
              color: isActive ? AppColors.primary : AppColors.grey400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
