import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_profile_cubit.dart';
import '../cubit/driver_profile_state.dart';

class DriverProfileView extends StatefulWidget {
  const DriverProfileView({super.key});

  @override
  State<DriverProfileView> createState() => _DriverProfileViewState();
}

class _DriverProfileViewState extends State<DriverProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<DriverProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50, // Slight off-white background
      appBar: AppBar(
        title: Text('Profile & Account', style: AppTextStyles.h2(context)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<DriverProfileCubit, DriverProfileState>(
        builder: (context, state) {
          if (state is DriverProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DriverProfileError) {
            return Center(child: Text(state.message));
          }
          if (state is! DriverProfileLoaded) {
            return const SizedBox.shrink();
          }

          final profile = state.profile;

          return SingleChildScrollView(
            child: Column(
              children: [
                // ── Old Profile Header Elements Combined with New Account Header ── //
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                    vertical: context.heightPct(24),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: context.widthPct(60),
                            height: context.widthPct(60),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.person,
                              color: const Color(0xFFC2185B),
                              size: 30,
                            ),
                          ),
                          SizedBox(width: context.widthPct(16)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.name,
                                  style: AppTextStyles.h2(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  'PRO TIER • ${profile.rating.toStringAsFixed(2)} RATING',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'ACTIVE',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Verified Member since 2022',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: context.heightPct(24)),

                      // Old Profile Stats Row
                      Row(
                        children: [
                          _StatCard(
                            label: 'Acceptance',
                            value: '94%',
                            color: AppColors.success,
                          ),
                          SizedBox(width: context.widthPct(12)),
                          _StatCard(
                            label: 'Cancellation',
                            value: '2%',
                            color: AppColors.error,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(16)),

                // ── Combined Middle Content ── //
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                  ),
                  child: Column(
                    children: [
                      // Vehicle Box
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(context.widthPct(20)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.grey200),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CURRENT VEHICLE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'EV-4029',
                                  style: AppTextStyles.h2(context).copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blueGrey.shade900,
                                  ),
                                ),
                                Text(
                                  'Metallic Burgundy',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.electric_car,
                                color: Colors.pink.shade100,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(16)),

                      // Weekly Goal
                      Container(
                        padding: EdgeInsets.all(context.widthPct(20)),
                        decoration: BoxDecoration(
                          color: const Color(0xFF151D29), // Dark slate blue
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WEEKLY GOAL',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '84%',
                                  style: AppTextStyles.h1(context).copyWith(
                                    color: const Color(0xFFE91E63),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  ' of 500 mi',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Stack(
                              children: [
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                Container(
                                  height: 6,
                                  width: context.widthPct(220),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE91E63),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // Old Profile Lifetime Stats
                      Container(
                        padding: EdgeInsets.all(context.widthPct(16)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lifetime Highlights',
                              style: AppTextStyles.h3(
                                context,
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: context.heightPct(12)),
                            _HighlightRow(
                              icon: Icons.thumb_up_outlined,
                              label: '5-Star Trips',
                              value: '4,289',
                            ),
                            SizedBox(height: context.heightPct(8)),
                            _HighlightRow(
                              icon: Icons.access_time,
                              label: 'Years Online',
                              value: '3.5',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // Documents & Compliance
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DOCUMENTS & COMPLIANCE',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '5 TOTAL',
                              style: TextStyle(
                                color: const Color(0xFFC2185B),
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(16)),

                      _DocumentItem(
                        icon: Icons.assignment_ind,
                        title: 'Driving License',
                        subtitle: 'Expires: Oct 2025',
                        status: 'VERIFIED',
                        isVerified: true,
                      ),
                      _DocumentItem(
                        icon: Icons.directions_car,
                        title: 'Car License',
                        subtitle: 'Plate: EV-4029',
                        status: 'VERIFIED',
                        isVerified: true,
                      ),
                      _DocumentItem(
                        icon: Icons.portrait,
                        title: 'Profile Photo',
                        subtitle: 'Updated 2 days ago',
                        status: 'PENDING',
                        isVerified: false,
                      ),
                      _DocumentItem(
                        icon: Icons.gavel,
                        title: 'Criminal Record',
                        subtitle: 'Annual Check',
                        status: 'VERIFIED',
                        isVerified: true,
                      ),
                      _DocumentItem(
                        icon: Icons.public,
                        title: 'Nationality ID',
                        subtitle: 'Government Issued',
                        status: 'VERIFIED',
                        isVerified: true,
                      ),

                      SizedBox(height: context.heightPct(24)),

                      // Action Buttons
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFC2185B),
                          side: BorderSide(color: Colors.pink.shade100),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.swap_horiz, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Switch Account',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(12)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade50,
                          foregroundColor: const Color(0xFFC2185B),
                          elevation: 0,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.logout, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'SIGN OUT',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(32)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavMenu(context),
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
                icon: Icons.account_balance_wallet_outlined,
                label: 'EARNINGS',
                onTap: () => context.go('/driver/earnings'),
              ),
              _NavIcon(
                icon: Icons.rocket_launch_outlined,
                label: 'BOOSTER',
                onTap: () => context.go('/driver/trips'),
              ),
              _NavIcon(
                icon: Icons.person,
                label: 'PROFILE',
                isActive: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.heightPct(12)),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.h2(
                context,
              ).copyWith(color: color, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.heightPct(4)),
            Text(label, style: AppTextStyles.caption(context)),
          ],
        ),
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
            color: AppColors.primary.withOpacity(0.1),
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
          style: AppTextStyles.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final bool isVerified;

  const _DocumentItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 20),
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
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: isVerified ? Colors.green : Colors.orange,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                isVerified ? Icons.check_circle : Icons.access_time_filled,
                color: isVerified ? Colors.green : Colors.orange,
                size: 14,
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
