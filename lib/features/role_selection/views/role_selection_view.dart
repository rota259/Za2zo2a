import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../cubit/role_selection_cubit.dart';
import '../cubit/role_selection_state.dart';
import '../widgets/role_card_widget.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RoleSelectionCubit(),
      child: const _RoleSelectionBody(),
    );
  }
}

class _RoleSelectionBody extends StatelessWidget {
  const _RoleSelectionBody();

  void _onContinue(BuildContext context, UserRole role) {
    if (role == UserRole.driver) {
      context.go('/driver/home');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = context.screenWidth;
    final bool isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 480 : double.infinity,
            ),
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────────
                _buildHeader(context),

                // ── Hero banner ──────────────────────────────────────────
                _buildHeroBanner(context),

                // ── Cards ────────────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(20),
                      vertical: context.heightPct(16),
                    ),
                    child: BlocBuilder<RoleSelectionCubit, RoleSelectionState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            RoleCardWidget(
                              role: UserRole.driver,
                              selectedRole: state.selectedRole,
                              icon: Icons.directions_car_rounded,
                              label: 'Driver',
                              subtitle: 'Drive and earn money',
                              badge: 'ACTIVE PARTNER',
                              badgeColor: AppColors.warning,
                              onTap: () => context
                                  .read<RoleSelectionCubit>()
                                  .selectRole(UserRole.driver),
                            ),
                            SizedBox(height: context.heightPct(14)),
                            RoleCardWidget(
                              role: UserRole.rider,
                              selectedRole: state.selectedRole,
                              icon: Icons.person_outline_rounded,
                              label: 'Rider',
                              subtitle: 'Book rides easily',
                              onTap: () => context
                                  .read<RoleSelectionCubit>()
                                  .selectRole(UserRole.rider),
                            ),
                            SizedBox(height: context.heightPct(28)),

                            // ── Continue button ───────────────────────────
                            _buildContinueButton(context, state.selectedRole),
                            SizedBox(height: context.heightPct(12)),
                            Text(
                              'BY CONTINUING YOU AGREE TO THE TERMS OF SERVICE',
                              style: AppTextStyles.caption(
                                context,
                              ).copyWith(letterSpacing: 0.4),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: context.heightPct(8)),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Widgets ────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(20),
        vertical: context.heightPct(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Za2zo2a',
            style: AppTextStyles.h3(context).copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: context.fontPct(17),
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/login'),
            child: Container(
              width: context.widthPct(32),
              height: context.widthPct(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grey200,
              ),
              child: Icon(
                Icons.close_rounded,
                size: context.widthPct(16),
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.heightPct(130),
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.widthPct(14)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.grey400, AppColors.grey300],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(context.widthPct(14)),
            child: Opacity(
              opacity: 0.12,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(20),
              vertical: context.heightPct(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Your Role',
                  style: AppTextStyles.h2(context).copyWith(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.heightPct(6)),
                Text(
                  'How would you like to use Za2zo2a today?',
                  style: AppTextStyles.bodySmall(
                    context,
                  ).copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context, UserRole role) {
    return SizedBox(
      width: double.infinity,
      height: context.heightPct(52),
      child: ElevatedButton(
        onPressed: () => _onContinue(context, role),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.widthPct(30)),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Continue', style: AppTextStyles.button(context)),
            SizedBox(width: context.widthPct(8)),
            const Icon(Icons.arrow_forward_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
