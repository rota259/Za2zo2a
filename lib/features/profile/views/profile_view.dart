import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && context.mounted) {
      context.read<ProfileCubit>().updateProfilePicture(image.path);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.grey50,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Rider Profile', style: AppTextStyles.h2(context)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.primary),
            onPressed: () {
              // Push into edit mode
            },
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          final name = state is ProfileLoaded ? state.name : 'Alex Rivera';
          final email = state is ProfileLoaded
              ? state.email
              : 'alex.rivera@voltride.com';
          final phone = state is ProfileLoaded
              ? state.phone
              : '+1 (555) 123-4567';
          final imagePath = state is ProfileLoaded
              ? state.profileImagePath
              : null;

          if (state is ProfileLoaded) {
            _nameController.text = name;
            _emailController.text = email;
            _phoneController.text = phone;
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ───── PROFILE HEADER SECTION ─────
                Container(
                  color: AppColors.background,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: context.heightPct(28),
                    horizontal: context.widthPct(24),
                  ),
                  child: Column(
                    children: [
                      // Avatar with PRO badge + camera
                      GestureDetector(
                        onTap: () => _pickImage(context),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Outer red ring
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 3,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: context.widthPct(46),
                                backgroundColor: AppColors.grey200,
                                backgroundImage: imagePath != null
                                    ? FileImage(File(imagePath))
                                    : null,
                                child: imagePath == null
                                    ? Icon(
                                        Icons.person,
                                        size: context.widthPct(46),
                                        color: AppColors.grey500,
                                      )
                                    : null,
                              ),
                            ),
                            // PRO badge
                            Positioned(
                              bottom: -context.heightPct(2),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.widthPct(10),
                                  vertical: context.heightPct(4),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(
                                    context.widthPct(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'PRO',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: context.fontPct(10),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    SizedBox(width: context.widthPct(4)),
                                    Icon(
                                      Icons.verified,
                                      color: Colors.white,
                                      size: context.fontPct(10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(20)),

                      // Name
                      Text(
                        name,
                        style: AppTextStyles.h2(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: context.heightPct(6)),

                      // Star Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: context.fontPct(16),
                          ),
                          SizedBox(width: context.widthPct(4)),
                          Text(
                            '4.9',
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' (128 reviews)',
                            style: AppTextStyles.bodySmall(
                              context,
                            ).copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(4)),

                      // Member since
                      Text(
                        'Member since March 2022',
                        style: AppTextStyles.bodySmall(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(16)),

                // ───── STATS ROW ─────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                  ),
                  child: Row(
                    children: [
                      // Total Trips
                      Expanded(
                        child: _StatCard(
                          icon: Icons.directions_car,
                          label: 'TOTAL TRIPS',
                          value: '142',
                          unit: '',
                        ),
                      ),
                      SizedBox(width: context.widthPct(16)),
                      // Distance
                      Expanded(
                        child: _StatCard(
                          icon: Icons.route,
                          label: 'DISTANCE',
                          value: '850',
                          unit: 'km',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(28)),

                // ───── PERSONAL INFORMATION ─────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                  ),
                  child: Text(
                    'PERSONAL INFORMATION',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: context.heightPct(12)),

                // Info Cards
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(context.widthPct(12)),
                  ),
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.person_outline,
                        label: 'Full Name',
                        value: name,
                        showDivider: true,
                        showCheck: false,
                        onTap: () {},
                      ),
                      _InfoRow(
                        icon: Icons.mail_outline,
                        label: 'Email Address',
                        value: email,
                        showDivider: true,
                        showCheck: true,
                        onTap: () {},
                      ),
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone Number',
                        value: phone,
                        showDivider: false,
                        showCheck: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(16)),

                // ───── PAYMENT METHODS ─────
                GestureDetector(
                  onTap: () => context.push('/home/payment'),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: context.widthPct(20),
                    ),
                    padding: EdgeInsets.all(context.widthPct(20)),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(context.widthPct(16)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.widthPct(12)),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: context.widthPct(22),
                          ),
                        ),
                        SizedBox(width: context.widthPct(16)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Methods',
                                style: AppTextStyles.bodyLarge(
                                  context,
                                ).copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Default: Visa ending in 4242',
                                style: AppTextStyles.bodySmall(
                                  context,
                                ).copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: context.heightPct(40)),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────
// Stat Card Widget
// ─────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(context.widthPct(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(context.widthPct(10)),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(context.widthPct(8)),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: context.widthPct(22),
            ),
          ),
          SizedBox(height: context.heightPct(12)),
          Text(
            label,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.heightPct(4)),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: AppTextStyles.h2(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                if (unit.isNotEmpty)
                  TextSpan(
                    text: ' $unit',
                    style: AppTextStyles.bodyMedium(context).copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
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

// ─────────────────────────────────────────
// Info Row Widget
// ─────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showDivider;
  final bool showCheck;
  final VoidCallback onTap;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.showDivider,
    required this.showCheck,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(16),
              vertical: context.heightPct(16),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.grey400,
                  size: context.widthPct(20),
                ),
                SizedBox(width: context.widthPct(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: AppColors.textSecondary,
                          fontSize: context.fontPct(11),
                        ),
                      ),
                      SizedBox(height: context.heightPct(2)),
                      Text(
                        value,
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showCheck)
                  Container(
                    padding: EdgeInsets.all(context.widthPct(4)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),
                    child: Icon(
                      Icons.check,
                      color: AppColors.primary,
                      size: context.fontPct(12),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.grey100,
            indent: context.widthPct(52),
          ),
      ],
    );
  }
}
