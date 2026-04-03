import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import 'package:go_router/go_router.dart';
import '../cubit/driver_earnings_cubit.dart';

class DriverEarningsView extends StatefulWidget {
  const DriverEarningsView({super.key});

  @override
  State<DriverEarningsView> createState() => _DriverEarningsViewState();
}

class _DriverEarningsViewState extends State<DriverEarningsView> {
  @override
  void initState() {
    super.initState();
    context.read<DriverEarningsCubit>().loadEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(16),
                vertical: context.heightPct(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.menu, color: Colors.black, size: 24),
                  SizedBox(width: context.widthPct(16)),
                  Text(
                    'VOLTRIDE',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: context.fontPct(18),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: context.widthPct(14),
                    backgroundColor: Colors.blueGrey.shade800,
                    child: Icon(
                      Icons.person,
                      color: Colors.amber.shade200,
                      size: context.widthPct(16),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.heightPct(20)),
                    Text(
                      'AVAILABLE BALANCE',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '\$2,840',
                          style: AppTextStyles.h1(context).copyWith(
                            fontSize: context.fontPct(48),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          '.50',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(16)),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                vertical: context.heightPct(16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => context.push('/driver/payment'),
                            child: Text(
                              'Withdraw',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: context.widthPct(12)),
                        Container(
                          padding: EdgeInsets.all(context.widthPct(14)),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.receipt_long_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(32)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weekly Pulse',
                          style: AppTextStyles.h3(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'MAY 12 - 18',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(16)),

                    // Mock Bar Chart
                    SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _Bar(day: 'MON', height: 40, active: false),
                          _Bar(day: 'TUE', height: 60, active: false),
                          _Bar(day: 'WED', height: 80, active: false),
                          _Bar(day: 'THU', height: 100, active: true),
                          _Bar(day: 'FRI', height: 30, active: false),
                          _Bar(day: 'SAT', height: 50, active: false),
                          _Bar(day: 'SUN', height: 70, active: false),
                        ],
                      ),
                    ),
                    SizedBox(height: context.heightPct(24)),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ONLINE TIME',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                '32h 45m',
                                style: AppTextStyles.h3(
                                  context,
                                ).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.grey200,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TOTAL TRIPS',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                '148',
                                style: AppTextStyles.h3(
                                  context,
                                ).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(32)),

                    Text(
                      'Performance',
                      style: AppTextStyles.h3(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.heightPct(16)),

                    _PerformanceItem(
                      icon: Icons.calendar_today_outlined,
                      title: 'Today vs Yesterday',
                      subtitle: 'DAILY VELOCITY',
                      percentage: '^12%',
                      amount: '+\$42.20',
                      isPositive: true,
                    ),
                    _PerformanceItem(
                      icon: Icons.show_chart,
                      title: 'This Week vs Last',
                      subtitle: 'WEEKLY MOMENTUM',
                      percentage: '^8.4%',
                      amount: '+\$180.00',
                      isPositive: true,
                    ),
                    _PerformanceItem(
                      icon: Icons.calendar_month_outlined,
                      title: 'Monthly Growth',
                      subtitle: 'LONG-TERM TREND',
                      percentage: 'v3.1%',
                      amount: '-\$112.40',
                      isPositive: false,
                    ),
                    SizedBox(height: context.heightPct(24)),

                    // Refer a friend box
                    Container(
                      padding: EdgeInsets.all(context.widthPct(20)),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade400,
                            Colors.deepOrange.shade600,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REFER A FRIEND',
                            style: AppTextStyles.h3(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Expand the fleet and earn high-voltage rewards.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$500',
                                style: AppTextStyles.h1(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 36,
                                ),
                              ),
                              SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'BONUS REWARD',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.deepOrange,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'SEND INVITE CODE',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.heightPct(32)),
                  ],
                ),
              ),
            ),

            _buildBottomNavMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
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
                onTap: () => context.go('/driver/home'),
              ),
              _NavIcon(
                icon: Icons.account_balance_wallet,
                label: 'EARNINGS',
                isActive: true,
                onTap: () {},
              ),
              _NavIcon(
                icon: Icons.rocket_launch_outlined,
                label: 'BOOSTER',
                onTap: () => context.go('/driver/trips'),
              ),
              _NavIcon(
                icon: Icons.person_outline,
                label: 'PROFILE',
                onTap: () => context.go('/driver/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String day;
  final double height;
  final bool active;

  const _Bar({required this.day, required this.height, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: height,
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontSize: 10,
            color: active ? AppColors.primary : AppColors.textSecondary,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _PerformanceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String percentage;
  final String amount;
  final bool isPositive;

  const _PerformanceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.percentage,
    required this.amount,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? Colors.green : AppColors.primary;
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grey200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                percentage,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                amount,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
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
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: isActive ? AppColors.primary : AppColors.grey400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
