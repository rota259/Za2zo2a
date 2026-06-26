import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../data/models/driver_model.dart';
import 'rating_stars.dart';

class ProfileHeader extends StatelessWidget {
  final DriverModel profile;
  final VoidCallback? onPhotoTap;

  const ProfileHeader({
    super.key,
    required this.profile,
    this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    final photoUrl = profile.profilePhotoUrl;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(20),
        vertical: context.heightPct(24),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onPhotoTap,
                child: _Avatar(photoUrl: photoUrl, onPhotoTap: onPhotoTap),
              ),
              SizedBox(width: context.widthPct(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: AppTextStyles.h2(context)
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: context.heightPct(6)),
                    Row(
                      children: [
                        RatingStars(rating: profile.rating),
                        SizedBox(width: context.widthPct(6)),
                        Text(
                          profile.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade800,
                          ),
                        ),
                        if (profile.totalReviews > 0) ...[
                          Text(
                            ' (${profile.totalReviews})',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: context.heightPct(8)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _StatusBadge(label: profile.verificationStatusLabel),
                        if (profile.formattedJoinDate.isNotEmpty)
                          Text(
                            'Member since ${profile.formattedJoinDate}',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(6)),
                    Text(
                      '${profile.completedTrips} completed trips',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (profile.acceptanceRate != null ||
              profile.cancellationRate != null) ...[
            SizedBox(height: context.heightPct(20)),
            Row(
              children: [
                if (profile.acceptanceRate != null)
                  Expanded(
                    child: _StatCard(
                      label: 'Acceptance',
                      value:
                          '${(profile.acceptanceRate! * 100).round()}%',
                      color: AppColors.success,
                    ),
                  ),
                if (profile.acceptanceRate != null &&
                    profile.cancellationRate != null)
                  SizedBox(width: context.widthPct(12)),
                if (profile.cancellationRate != null)
                  Expanded(
                    child: _StatCard(
                      label: 'Cancellation',
                      value:
                          '${(profile.cancellationRate! * 100).round()}%',
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? photoUrl;
  final VoidCallback? onPhotoTap;

  const _Avatar({this.photoUrl, this.onPhotoTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthPct(60),
      height: context.widthPct(60),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(12),
        image: photoUrl != null
            ? DecorationImage(
                image: NetworkImage(photoUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: photoUrl == null
          ? Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: const Color(0xFFC2185B),
                  size: 30,
                ),
                if (onPhotoTap != null)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            )
          : null,
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;

  const _StatusBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final isVerified = label == 'Verified';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isVerified ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: isVerified ? Colors.green : Colors.orange.shade800,
          fontSize: 8,
          fontWeight: FontWeight.bold,
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
    return Container(
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
            style: AppTextStyles.h2(context)
                .copyWith(color: color, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: context.heightPct(4)),
          Text(label, style: AppTextStyles.caption(context)),
        ],
      ),
    );
  }
}
