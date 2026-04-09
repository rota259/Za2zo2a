import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../map_constants.dart';

class MapFloatingActions extends StatelessWidget {
  final bool isFollowingUser;
  final bool showNavigateButton;
  final VoidCallback onNavigate;
  final VoidCallback onCenterOnUserLocation;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const MapFloatingActions({
    super.key,
    required this.isFollowingUser,
    required this.showNavigateButton,
    required this.onNavigate,
    required this.onCenterOnUserLocation,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showNavigateButton)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FloatingActionButton.extended(
              heroTag: 'navigate_button',
              onPressed: onNavigate,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.navigation_rounded),
              label: const Text(MapConstants.navigateLabel),
            ),
          ),
        _MapActionButton(
          icon: isFollowingUser ? Icons.my_location_rounded : Icons.gps_fixed,
          tooltip: isFollowingUser
              ? MapConstants.centerLocationTooltip
              : MapConstants.resumeTrackingTooltip,
          onTap: onCenterOnUserLocation,
          backgroundColor: Colors.white,
          iconColor: AppColors.info,
        ),
        const SizedBox(height: 12),
        _MapActionButton(
          icon: Icons.add,
          tooltip: MapConstants.zoomInTooltip,
          onTap: onZoomIn,
          backgroundColor: Colors.white,
          iconColor: AppColors.textPrimary,
        ),
        const SizedBox(height: 8),
        _MapActionButton(
          icon: Icons.remove,
          tooltip: MapConstants.zoomOutTooltip,
          onTap: onZoomOut,
          backgroundColor: Colors.white,
          iconColor: AppColors.textPrimary,
        ),
      ],
    );
  }
}

class _MapActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  const _MapActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
    );
  }
}
