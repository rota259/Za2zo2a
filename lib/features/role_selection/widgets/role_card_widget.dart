import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../cubit/role_selection_state.dart';

class RoleCardWidget extends StatelessWidget {
  final UserRole role;
  final UserRole selectedRole;
  final IconData icon;
  final String label;
  final String subtitle;
  final String? badge;
  final Color? badgeColor;
  final VoidCallback onTap;

  const RoleCardWidget({
    super.key,
    required this.role,
    required this.selectedRole,
    required this.icon,
    required this.label,
    required this.subtitle,
    this.badge,
    this.badgeColor,
    required this.onTap,
  });

  bool get _isSelected => role == selectedRole;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _isSelected
            ? AppColors.primary.withValues(alpha: 0.07)
            : AppColors.background,
        borderRadius: BorderRadius.circular(context.widthPct(16)),
        border: Border.all(
          color: _isSelected ? AppColors.primary : AppColors.grey200,
          width: _isSelected ? 2 : 1,
        ),
        boxShadow: _isSelected
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(context.widthPct(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(context.widthPct(16)),
          child: Padding(
            padding: EdgeInsets.all(context.widthPct(18)),
            child: Row(
              children: [
                // ── Icon Container ──────────────────────────────────────
                _buildIconBox(context),
                SizedBox(width: context.widthPct(16)),

                // ── Label & Subtitle ────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: AppTextStyles.h3(context).copyWith(
                          fontSize: context.fontPct(16),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: context.heightPct(4)),
                      Text(subtitle, style: AppTextStyles.bodySmall(context)),
                      if (badge != null) ...[
                        SizedBox(height: context.heightPct(8)),
                        _buildBadge(context),
                      ],
                    ],
                  ),
                ),

                // ── Check icon ──────────────────────────────────────────
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isSelected ? 1.0 : 0.0,
                  child: Container(
                    width: context.widthPct(24),
                    height: context.widthPct(24),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: context.widthPct(14),
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

  Widget _buildIconBox(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: context.widthPct(52),
      height: context.widthPct(52),
      decoration: BoxDecoration(
        color: _isSelected
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.grey100,
        borderRadius: BorderRadius.circular(context.widthPct(12)),
      ),
      child: Icon(
        icon,
        color: _isSelected ? AppColors.primary : AppColors.grey500,
        size: context.widthPct(26),
      ),
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.widthPct(7),
          height: context.widthPct(7),
          decoration: BoxDecoration(
            color: badgeColor ?? AppColors.warning,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: context.widthPct(5)),
        Text(
          badge!,
          style: AppTextStyles.caption(context).copyWith(
            color: badgeColor ?? AppColors.warning,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}
