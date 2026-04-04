import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import 'widgets/app_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.heightPct(10)),
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: Container(
                        padding: EdgeInsets.all(context.widthPct(10)),
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.menu, color: AppColors.textPrimary),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(12),
                            vertical: context.heightPct(8),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.grey100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: AppColors.primary, size: 16),
                              SizedBox(width: 4),
                              Text('5.0', style: AppTextStyles.bodySmall(context).copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(width: context.widthPct(10)),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.grey200,
                          child: Icon(Icons.person, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: context.heightPct(30)),
                
                // Greeting
                Text('Welcome back, Alex!', style: AppTextStyles.h1(context)),
                SizedBox(height: context.heightPct(24)),
                
                // Where to? Button
                GestureDetector(
                  onTap: () => context.push('/map'),
                  child: Container(
                    padding: EdgeInsets.all(context.widthPct(16)),
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: BorderRadius.circular(context.widthPct(16)),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: context.widthPct(28), color: AppColors.textPrimary),
                        SizedBox(width: context.widthPct(12)),
                        Text('Where to?', style: AppTextStyles.h2(context)),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(context.widthPct(8)),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.schedule, size: 20, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.heightPct(30)),
                
                // Quick Actions (Ride, Package, etc.)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _QuickActionCard(
                      title: 'Ride',
                      icon: Icons.directions_car,
                      onTap: () => context.push('/map'),
                      isPrimary: true,
                    ),
                    _QuickActionCard(
                      title: 'Package',
                      icon: Icons.local_shipping,
                      onTap: () {},
                      isPrimary: false,
                    ),
                  ],
                ),
                SizedBox(height: context.heightPct(30)),
                
                // Saved Places
                Text('Around You', style: AppTextStyles.h3(context)),
                SizedBox(height: context.heightPct(16)),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.grey100,
                    child: Icon(Icons.home, color: AppColors.textPrimary),
                  ),
                  title: Text('Home', style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
                  subtitle: Text('123 Main St, New York', style: AppTextStyles.bodySmall(context)),
                  onTap: () => context.push('/map'),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.grey100,
                    child: Icon(Icons.work, color: AppColors.textPrimary),
                  ),
                  title: Text('Work', style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
                  subtitle: Text('456 Market St, San Francisco', style: AppTextStyles.bodySmall(context)),
                  onTap: () => context.push('/map'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.widthPct(160),
        padding: EdgeInsets.symmetric(
          vertical: context.heightPct(24),
          horizontal: context.widthPct(16),
        ),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.grey100,
          borderRadius: BorderRadius.circular(context.widthPct(16)),
        ),
        child: Column(
          children: [
            Icon(icon, size: context.widthPct(40), color: isPrimary ? Colors.white : AppColors.textPrimary),
            SizedBox(height: context.heightPct(12)),
            Text(
              title,
              style: AppTextStyles.bodyLarge(context).copyWith(
                color: isPrimary ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
