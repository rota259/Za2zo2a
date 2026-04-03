import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Settings',
          style: AppTextStyles.h3(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.heightPct(20)),
            // ── Profile Section
            Center(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: context.widthPct(50),
                      backgroundImage: const NetworkImage(
                        'https://i.pravatar.cc/150?u=alexvolt',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: context.widthPct(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.heightPct(16)),
            Text(
              'Alex Volt',
              style: AppTextStyles.h2(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            Text('alex@za2zo2a.com', style: AppTextStyles.bodySmall(context)),
            Text('+1 (555) 012-3456', style: AppTextStyles.bodySmall(context)),
            SizedBox(height: context.heightPct(30)),

            // ── Preferences Section
            _buildSectionHeader(context, 'PREFERENCES'),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  iconColor: AppColors.primary,
                  iconBg: const Color(0xFFFFEBEB),
                  title: 'Dark Mode',
                  trailing: Switch.adaptive(
                    value: themeMode == ThemeMode.dark,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                );
              },
            ),
            _SettingsTile(
              icon: Icons.translate,
              iconColor: Colors.orange,
              iconBg: const Color(0xFFFFF4E5),
              title: 'Language',
              subtitle: 'English (US)',
              onTap: () {},
            ),

            // ── Saved Locations
            _buildSectionHeader(context, 'SAVED LOCATIONS'),
            _SettingsTile(
              icon: Icons.home_outlined,
              iconColor: Colors.blueGrey,
              iconBg: AppColors.grey100,
              title: 'Add Home',
              trailing: Icon(
                Icons.add_circle_outline,
                color: AppColors.grey400,
              ),
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.work_outline,
              iconColor: Colors.blueGrey,
              iconBg: AppColors.grey100,
              title: 'Add Work',
              trailing: Icon(
                Icons.add_circle_outline,
                color: AppColors.grey400,
              ),
              onTap: () {},
            ),

            // ── Security & Legal
            _buildSectionHeader(context, 'SECURITY & LEGAL'),
            _SettingsTile(
              icon: Icons.shield_outlined,
              iconColor: AppColors.primary,
              iconBg: const Color(0xFFFFEBEB),
              title: 'Privacy Settings',
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.description_outlined,
              iconColor: Colors.blueGrey,
              iconBg: AppColors.grey100,
              title: 'Terms of Service',
              trailing: Icon(
                Icons.open_in_new,
                color: AppColors.grey400,
                size: 18,
              ),
              onTap: () {},
            ),

            SizedBox(height: context.heightPct(32)),
            // ── Sign Out Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(24)),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F4F6),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.widthPct(12)),
                    ),
                  ),
                  onPressed: () => context.go('/login'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: AppColors.primary, size: 20),
                      SizedBox(width: context.widthPct(8)),
                      Text(
                        'Sign Out',
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: context.heightPct(24)),
            Text(
              'ZA2ZO2A VERSION 4.2.0 (BUILD 882)',
              style: AppTextStyles.caption(
                context,
              ).copyWith(color: AppColors.grey400, letterSpacing: 1.1),
            ),
            SizedBox(height: context.heightPct(32)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: context.widthPct(24),
        top: context.heightPct(20),
        bottom: context.heightPct(12),
      ),
      child: Text(
        title,
        style: AppTextStyles.caption(context).copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: context.widthPct(24)),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge(
          context,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: AppTextStyles.bodySmall(context))
          : null,
      trailing:
          trailing ??
          Icon(Icons.chevron_right, color: AppColors.grey400, size: 20),
      onTap: onTap,
    );
  }
}
