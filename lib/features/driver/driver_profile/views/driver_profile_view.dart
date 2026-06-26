import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../data/models/driver_model.dart';
import '../data/models/verification_model.dart';
import '../cubit/driver_profile_cubit.dart';
import '../cubit/driver_profile_state.dart';
import 'widgets/goal_progress_card.dart';
import 'widgets/lifetime_highlights.dart';
import 'widgets/profile_header.dart';
import 'widgets/verification_section.dart';

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

  Future<void> _pickAndUpload(VerificationDocumentType type) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null || !mounted) return;
    try {
      await context.read<DriverProfileCubit>().uploadDocument(
            type: type,
            filePath: image.path,
          );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<DriverProfileCubit>().loadProfile(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final profile = switch (state) {
            DriverProfileLoaded(:final profile) => profile,
            DriverProfileUpdating(:final profile) => profile,
            _ => null,
          };

          if (profile == null) {
            return const SizedBox.shrink();
          }

          final isUpdating = state is DriverProfileUpdating;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileHeader(
                      profile: profile,
                      onPhotoTap: () => _pickAndUpload(
                        VerificationDocumentType.profilePhoto,
                      ),
                    ),
                    SizedBox(height: context.heightPct(16)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(20),
                      ),
                      child: Column(
                        children: [
                          _VehicleCard(profile: profile),
                          SizedBox(height: context.heightPct(16)),
                          GoalProgressCard(profile: profile),
                          SizedBox(height: context.heightPct(24)),
                          LifetimeHighlights(profile: profile),
                          SizedBox(height: context.heightPct(24)),
                          VerificationSection(
                            verification: profile.verification,
                            onUploadTap: _pickAndUpload,
                          ),
                          SizedBox(height: context.heightPct(24)),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFC2185B),
                              side: BorderSide(color: Colors.pink.shade100),
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => context.push('/signup'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.swap_horiz, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Switch to Rider',
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
                            onPressed: () async {
                              await context.read<AuthCubit>().logout();
                              if (context.mounted) context.go('/login');
                            },
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
              ),
              if (isUpdating)
                const ColoredBox(
                  color: Color(0x33000000),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavMenu(context),
    );
  }

  Widget _buildBottomNavMenu(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                icon: Icons.history,
                label: 'HISTORY',
                onTap: () => context.go('/driver/home'),
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

class _VehicleCard extends StatelessWidget {
  final DriverModel profile;

  const _VehicleCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              const SizedBox(height: 8),
              Text(
                profile.licensePlate.isNotEmpty ? profile.licensePlate : '—',
                style: AppTextStyles.h2(context).copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.blueGrey.shade900,
                ),
              ),
              Text(
                profile.vehicleDisplay.isNotEmpty
                    ? profile.vehicleDisplay
                    : '—',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.15,
              child: Icon(
                Icons.electric_car,
                color: Colors.pink.shade200,
                size: 40,
              ),
            ),
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
          const SizedBox(height: 4),
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
