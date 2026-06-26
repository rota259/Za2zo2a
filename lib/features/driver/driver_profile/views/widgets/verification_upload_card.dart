import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../data/models/verification_model.dart';

class VerificationUploadCard extends StatelessWidget {
  final VerificationItemModel item;
  final VoidCallback? onTap;

  const VerificationUploadCard({
    super.key,
    required this.item,
    this.onTap,
  });

  IconData get _icon {
    switch (item.type) {
      case VerificationDocumentType.profilePhoto:
        return Icons.portrait;
      case VerificationDocumentType.driverLicense:
        return Icons.assignment_ind;
      case VerificationDocumentType.nationalId:
        return Icons.badge_outlined;
      case VerificationDocumentType.vehicleLicense:
        return Icons.directions_car;
      case VerificationDocumentType.criminalRecord:
        return Icons.gavel;
    }
  }

  String get _subtitle {
    if (item.isPending) return 'Waiting for approval';
    if (item.status == VerificationStatus.rejected &&
        item.rejectionReason != null) {
      return item.rejectionReason!;
    }
    if (item.uploadedAt != null && item.uploadedAt!.isNotEmpty) {
      return 'Uploaded';
    }
    if (item.status == VerificationStatus.notUploaded) {
      return 'Tap to upload';
    }
    return '';
  }

  Color get _statusColor {
    if (item.showsCheck) return Colors.green;
    if (item.isPending) return Colors.orange;
    if (item.status == VerificationStatus.rejected) return AppColors.error;
    return AppColors.textSecondary;
  }

  String get _statusLabel {
    switch (item.status) {
      case VerificationStatus.notUploaded:
        return 'NOT UPLOADED';
      case VerificationStatus.pending:
        return 'PENDING';
      case VerificationStatus.approved:
        return 'APPROVED';
      case VerificationStatus.rejected:
        return 'REJECTED';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(_icon, color: AppColors.textSecondary, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.type.label,
                        style: AppTextStyles.bodyMedium(context)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (_subtitle.isNotEmpty)
                        Text(
                          _subtitle,
                          style: TextStyle(
                            fontSize: 10,
                            color: item.isPending
                                ? Colors.orange.shade800
                                : AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _statusLabel,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: _statusColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (item.showsCheck)
                      Icon(Icons.check_circle, color: _statusColor, size: 16)
                    else if (item.isPending)
                      Icon(Icons.access_time_filled,
                          color: _statusColor, size: 16)
                    else if (item.status == VerificationStatus.rejected)
                      Icon(Icons.error_outline, color: _statusColor, size: 16)
                    else
                      Icon(Icons.upload_file,
                          color: AppColors.textSecondary, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
