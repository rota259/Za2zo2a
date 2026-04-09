import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/driver_info_entity.dart';
import 'driver_info_card.dart';
import 'ride_action_buttons.dart';

class EtaPanel extends StatelessWidget {
  final bool isTablet;
  final String eta;
  final String arrivalTime;
  final String distanceKm;
  final double tripProgress;
  final DriverInfoEntity driverInfo;
  final VoidCallback onCall;
  final VoidCallback onChat;
  final VoidCallback onShareStatus;
  final VoidCallback onEmergency;

  const EtaPanel({
    super.key,
    required this.isTablet,
    required this.eta,
    required this.arrivalTime,
    required this.distanceKm,
    required this.tripProgress,
    required this.driverInfo,
    required this.onCall,
    required this.onChat,
    required this.onShareStatus,
    required this.onEmergency,
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
              Text(
                eta,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onCall,
                icon: const Icon(Icons.call_outlined),
              ),
              IconButton(
                onPressed: onChat,
                icon: const Icon(Icons.chat_bubble_outline),
              ),
            ],
          ),
          Text(
            '${AppStrings.arrivingAt} $arrivalTime - $distanceKm ${AppStrings.distanceUnitKm}',
            style: TextStyle(color: AppColors.greyText),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: tripProgress,
            minHeight: 6,
            borderRadius: BorderRadius.circular(999),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            backgroundColor: AppColors.grey200,
          ),
          DriverInfoCard(driverInfo: driverInfo),
          const SizedBox(height: 12),
          RideActionButtons(
            onShareStatus: onShareStatus,
            onEmergency: onEmergency,
          ),
        ],
      ),
    );
  }
}
