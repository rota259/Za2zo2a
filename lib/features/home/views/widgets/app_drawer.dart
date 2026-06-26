import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/cubit/auth_state.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/cubit/profile_state.dart';
import 'dart:io';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          // ── Red Header
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              final authState = context.watch<AuthCubit>().state;
              final user = authState is Authenticated ? authState.user : null;
              final name = user?.name ??
                  (state is ProfileLoaded ? state.name : 'User');
              final rating = user?.rating;
              final imagePath = state is ProfileLoaded
                  ? state.profileImagePath
                  : null;

              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: context.heightPct(56),
                  bottom: context.heightPct(24),
                  left: context.widthPct(20),
                  right: context.widthPct(20),
                ),
                color: AppColors.primary,
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: context.widthPct(28),
                      backgroundColor: AppColors.grey200,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath))
                          : null,
                      child: imagePath == null
                          ? Icon(
                              Icons.person,
                              size: context.widthPct(30),
                              color: AppColors.grey500,
                            )
                          : null,
                    ),
                    SizedBox(width: context.widthPct(16)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.h3(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: context.heightPct(4)),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: context.fontPct(13),
                            ),
                            SizedBox(width: context.widthPct(2)),
                            Text(
                              rating != null
                                  ? '${rating.toStringAsFixed(1)} Rating'
                                  : '',
                              style: AppTextStyles.bodySmall(
                                context,
                              ).copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          // ── Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: context.heightPct(8)),
              children: [
                _DrawerItem(
                  icon: Icons.credit_card_outlined,
                  iconColor: AppColors.primary,
                  title: 'Payments',
                  onTap: () => context.push('/payment'),
                ),
                _DrawerItem(
                  icon: Icons.notifications_none_outlined,
                  iconColor: AppColors.primary,
                  title: 'Notifications',
                  onTap: () => context.push('/notifications'),
                ),
                _DrawerItem(
                  icon: Icons.person_outline,
                  iconColor: AppColors.primary,
                  title: 'Account',
                  onTap: () => context.push('/profile'),
                ),
                _DrawerItem(
                  icon: Icons.history,
                  iconColor: AppColors.primary,
                  title: 'Trip History',
                  onTap: () => context.push('/trips'),
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  iconColor: AppColors.primary,
                  title: 'Settings',
                  onTap: () => context.push('/settings'),
                ),
                _DrawerItem(
                  icon: Icons.swap_horiz,
                  iconColor: AppColors.primary,
                  title: 'Become a Driver',
                  onTap: () => context.push('/signup/driver'),
                ),
                _DrawerItem(
                  icon: Icons.help_outline,
                  iconColor: AppColors.primary,
                  title: 'Help & Support',
                  onTap: () {},
                ),

                // ── Safety Center section
                Padding(
                  padding: EdgeInsets.only(
                    left: context.widthPct(20),
                    top: context.heightPct(20),
                    bottom: context.heightPct(8),
                  ),
                  child: Text(
                    'SAFETY CENTER',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),

                // Safety header tile
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.widthPct(12),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(context.widthPct(10)),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.shield_outlined,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      'Safety Services',
                      style: AppTextStyles.bodyLarge(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {},
                  ),
                ),

                SizedBox(height: context.heightPct(4)),

                // Sub-items
                _SubDrawerItem(
                  icon: Icons.contact_emergency_outlined,
                  title: 'Call Emergency Contacts',
                  onTap: () => context.push('/safety'),
                ),
                _SubDrawerItem(
                  icon: Icons.emergency_outlined,
                  title: 'Call 122',
                  onTap: () => context.push('/safety'),
                ),
                _SubDrawerItem(
                  icon: Icons.support_agent_outlined,
                  title: 'Safety Support',
                  onTap: () => context.push('/safety'),
                ),

                SizedBox(height: context.heightPct(16)),

                // ── Earn with us banner
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.widthPct(12),
                  ),
                  padding: EdgeInsets.all(context.widthPct(14)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(context.widthPct(12)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.orange.shade700),
                      SizedBox(width: context.widthPct(10)),
                      Text(
                        'Earn with us',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: context.widthPct(8)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(8),
                          vertical: context.heightPct(2),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade700,
                          borderRadius: BorderRadius.circular(
                            context.widthPct(4),
                          ),
                        ),
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: context.fontPct(10),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Footer: version + sign out
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(20),
              vertical: context.heightPct(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Za2zo2a v2.4.0',
                  style: AppTextStyles.bodySmall(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
                GestureDetector(
                  onTap: () async {
                    await context.read<AuthCubit>().logout();
                    if (context.mounted) context.go('/login');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: AppColors.primary,
                        size: context.fontPct(16),
                      ),
                      SizedBox(width: context.widthPct(4)),
                      Text(
                        ' Sign Out',
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
      leading: Container(
        padding: EdgeInsets.all(context.widthPct(8)),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(context.widthPct(8)),
        ),
        child: Icon(icon, color: iconColor, size: context.widthPct(20)),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge(
          context,
        ).copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.grey400,
        size: context.widthPct(20),
      ),
      onTap: () {
        context.pop();
        onTap();
      },
    );
  }
}

class _SubDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SubDrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.widthPct(28),
        vertical: 0,
      ),
      dense: true,
      leading: Icon(
        icon,
        size: context.widthPct(20),
        color: AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium(
          context,
        ).copyWith(color: AppColors.textPrimary),
      ),
      onTap: () {
        context.pop();
        onTap();
      },
    );
  }
}
