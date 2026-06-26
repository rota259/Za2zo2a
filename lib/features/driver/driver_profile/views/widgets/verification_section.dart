import 'package:flutter/material.dart';

import '../../../../../core/utils/responsive.dart';
import '../../data/models/verification_model.dart';
import 'verification_upload_card.dart';

class VerificationSection extends StatelessWidget {
  final VerificationModel verification;
  final void Function(VerificationDocumentType type)? onUploadTap;

  const VerificationSection({
    super.key,
    required this.verification,
    this.onUploadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${verification.items.length} TOTAL',
                style: TextStyle(
                  color: const Color(0xFFC2185B),
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.heightPct(12)),
        ...verification.items.map(
          (item) => VerificationUploadCard(
            item: item,
            onTap: onUploadTap != null ? () => onUploadTap!(item.type) : null,
          ),
        ),
      ],
    );
  }
}
