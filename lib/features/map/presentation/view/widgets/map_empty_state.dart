import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../map_constants.dart';

class MapEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onRetry;

  const MapEmptyState({
    super.key,
    required this.title,
    required this.description,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off_outlined, size: 72, color: AppColors.error),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text(MapConstants.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
