import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/services/session_manager.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../injection_container.dart';
import 'package:go_router/go_router.dart';
import '../cubit/driver_earnings_cubit.dart';
import '../cubit/driver_earnings_state.dart';
import '../data/models/driver_earnings_model.dart';

class DriverEarningsView extends StatefulWidget {
  const DriverEarningsView({super.key});

  @override
  State<DriverEarningsView> createState() => _DriverEarningsViewState();
}

class _DriverEarningsViewState extends State<DriverEarningsView> {
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    context.read<DriverEarningsCubit>().loadEarnings();
    _loadPhoto();
  }

  Future<void> _loadPhoto() async {
    final path = await sl<SessionManager>().readProfilePhoto();
    if (mounted && path != null) setState(() => _photoPath = path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(16),
                vertical: context.heightPct(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.menu, color: Colors.black, size: 24),
                  SizedBox(width: context.widthPct(16)),
                  Expanded(
                    child: Text('ZA2ZO2A',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: context.fontPct(18),
                            letterSpacing: 1.2)),
                  ),
                  CircleAvatar(
                    radius: context.widthPct(14),
                    backgroundColor: Colors.blueGrey.shade800,
                    backgroundImage: _photoPath != null
                        ? FileImage(File(_photoPath!))
                        : null,
                    child: _photoPath == null
                        ? Icon(Icons.person,
                            color: Colors.amber.shade200,
                            size: context.widthPct(16))
                        : null,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<DriverEarningsCubit, DriverEarningsState>(
                builder: (context, state) {
                  if (state is DriverEarningsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is DriverEarningsError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.message, textAlign: TextAlign.center),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<DriverEarningsCubit>().loadEarnings(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is DriverEarningsLoaded) {
                    return _buildContent(context, state.earnings);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            _buildBottomNavMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DriverEarningsModel e) {
    final breakdown = e.weeklyBreakdown;
    final maxAmount = breakdown.isEmpty
        ? 1.0
        : breakdown.map((d) => d.amount).reduce((a, b) => a > b ? a : b);
    final today = DateTime.now().weekday; // 1=Mon … 7=Sun

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.heightPct(20)),
          Text('AVAILABLE BALANCE',
              style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0)),
          _balanceRow(context, e.pendingBalance),
          SizedBox(height: context.heightPct(16)),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(16)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => context.push('/driver/payment'),
                  child: Text('Withdraw',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
              SizedBox(width: context.widthPct(12)),
              Container(
                padding: EdgeInsets.all(context.widthPct(14)),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey200),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.receipt_long_outlined, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(32)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Weekly Pulse',
                  style: AppTextStyles.h3(context)
                      .copyWith(fontWeight: FontWeight.bold)),
              Text(_weekRange(),
                  style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0)),
            ],
          ),
          SizedBox(height: context.heightPct(16)),
          // CHART — real weeklyBreakdown from /api/driver/earnings
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: breakdown.isEmpty
                  ? _emptyBars()
                  : List.generate(breakdown.length, (i) {
                      final d = breakdown[i];
                      final h = maxAmount > 0
                          ? (d.amount / maxAmount * 100).clamp(4.0, 100.0)
                          : 4.0;
                      final dayIndex = i + 1;
                      return _Bar(
                          day: d.day.length > 3
                              ? d.day.substring(0, 3).toUpperCase()
                              : d.day.toUpperCase(),
                          height: h,
                          active: dayIndex == today);
                    }),
            ),
          ),
          SizedBox(height: context.heightPct(24)),
          Row(
            children: [
              Expanded(
                child: _statColumn('TOTAL EARNINGS',
                    '${e.currency} ${e.totalEarnings.toStringAsFixed(0)}'),
              ),
              Container(width: 1, height: 40, color: AppColors.grey200),
              const SizedBox(width: 20),
              Expanded(
                child: _statColumn('TOTAL TRIPS', '${e.totalTrips}'),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(16)),
          Row(
            children: [
              Expanded(
                child: _statColumn('AVG FARE',
                    '${e.currency} ${e.avgFare.toStringAsFixed(1)}'),
              ),
              Container(width: 1, height: 40, color: AppColors.grey200),
              const SizedBox(width: 20),
              Expanded(
                child: _statColumn('LIFETIME',
                    '${e.currency} ${e.totalLifetime.toStringAsFixed(0)}'),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(32)),
        ],
      ),
    );
  }

  Widget _balanceRow(BuildContext context, double amount) {
    final whole = amount.toInt().toString();
    final frac = (amount - amount.toInt()).toStringAsFixed(2).substring(1);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(
          child: Text('EGP $whole',
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h1(context).copyWith(
                  fontSize: context.fontPct(48),
                  fontWeight: FontWeight.w900)),
        ),
        Text(frac,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ],
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0)),
        Text(value,
            style: AppTextStyles.h3(context)
                .copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  List<Widget> _emptyBars() {
    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days
        .map((d) => _Bar(day: d, height: 4, active: false))
        .toList();
  }

  String _weekRange() {
    final now = DateTime.now();
    final mon = now.subtract(Duration(days: now.weekday - 1));
    final sun = mon.add(const Duration(days: 6));
    return '${_monthAbbr(mon.month)} ${mon.day} - ${sun.day}';
  }

  String _monthAbbr(int m) {
    const months = [
      '', 'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return months[m];
  }

  Widget _buildBottomNavMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(icon: Icons.dashboard_outlined, label: 'HOME',
                  onTap: () => context.go('/driver/home')),
              _NavIcon(icon: Icons.account_balance_wallet, label: 'EARNINGS',
                  isActive: true, onTap: () {}),
              _NavIcon(icon: Icons.history, label: 'HISTORY',
                  onTap: () => context.go('/driver/home')),
              _NavIcon(icon: Icons.person_outline, label: 'PROFILE',
                  onTap: () => context.go('/driver/profile')),
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
                : AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        SizedBox(height: 8),
        Text(day,
            style: TextStyle(
                fontSize: 10,
                color: active ? AppColors.primary : AppColors.textSecondary,
                fontWeight: active ? FontWeight.bold : FontWeight.normal)),
      ],
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
          Icon(icon,
              color: isActive ? AppColors.primary : AppColors.grey400,
              size: 24),
          SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 9,
                  color: isActive ? AppColors.primary : AppColors.grey400,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
