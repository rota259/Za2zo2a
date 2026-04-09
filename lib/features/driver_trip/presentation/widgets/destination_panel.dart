import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/destination_entity.dart';
import 'end_trip_button.dart';
import 'navigate_button.dart';

class DestinationPanel extends StatelessWidget {
  final bool isTablet;
  final DestinationEntity destination;
  final String distanceKm;
  final String tripTime;
  final VoidCallback onNavigate;
  final VoidCallback onEndTrip;

  const DestinationPanel({
    super.key,
    required this.isTablet,
    required this.destination,
    required this.distanceKm,
    required this.tripTime,
    required this.onNavigate,
    required this.onEndTrip,
  });

  @override
  Widget build(BuildContext context) {
    final radius = isTablet
        ? BorderRadius.circular(24)
        : const BorderRadius.vertical(top: Radius.circular(24));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: radius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _LabelValue(
                  label: AppStrings.currentDestination,
                  value: destination.address,
                ),
              ),
              const SizedBox(width: 12),
              _LabelValue(
                label: AppStrings.constantPrice,
                value:
                    '${AppStrings.currencySymbol}${destination.price.toStringAsFixed(2)}',
                valueColor: AppColors.primary,
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text('$distanceKm ${AppStrings.distanceUnitKm}'),
              const SizedBox(width: 24),
              Icon(Icons.timer, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(tripTime),
            ],
          ),
          const SizedBox(height: 16),
          NavigateButton(onTap: onNavigate),
          const SizedBox(height: 8),
          EndTripButton(onTap: onEndTrip),
        ],
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _LabelValue({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1.1,
            color: AppColors.greyText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textPrimary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
