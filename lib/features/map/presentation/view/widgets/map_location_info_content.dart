import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/search_result_model.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_state.dart';

class MapLocationInfoContent extends StatelessWidget {
  final MapLocationLoaded state;
  final SearchResultModel? destinationDetails;
  final bool isRouteFetching;
  final VoidCallback onTripAction;

  const MapLocationInfoContent({
    super.key,
    required this.state,
    required this.destinationDetails,
    required this.isRouteFetching,
    required this.onTripAction,
  });

  @override
  Widget build(BuildContext context) {
    final hasDestination = state.destination != null;
    final statusLabel = state.isFollowingUser
        ? MapConstants.followStatusOnLabel
        : MapConstants.followStatusOffLabel;
    final title = hasDestination
        ? destinationDetails?.title ?? MapConstants.selectedDestinationFallback
        : MapConstants.noDestinationTitle;
    final description = hasDestination
        ? destinationDetails?.displayName ?? MapConstants.routePendingLabel
        : MapConstants.noDestinationDescription;
    final buttonLabel = state.isTripActive
        ? MapConstants.endTripLabel
        : MapConstants.startTripLabel;
    final distanceValue = state.distanceText ?? MapConstants.noDistanceValue;
    final durationValue = state.durationText ?? MapConstants.noDurationValue;
    final buttonEnabled = state.isTripActive || hasDestination;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              MapConstants.routePanelTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            _MapStatusChip(
              label: statusLabel,
              color: state.isFollowingUser ? AppColors.info : AppColors.warning,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _MapInfoTile(
                label: MapConstants.distanceLabel,
                value: distanceValue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MapInfoTile(
                label: MapConstants.durationLabel,
                value: durationValue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _MapInfoTile(
          label: MapConstants.currentLocationLabel,
          value: _formatCoordinates(state.userLocation),
        ),
        if (hasDestination) ...[
          const SizedBox(height: 16),
          _MapInfoTile(
            label: MapConstants.destinationLabel,
            value: _formatCoordinates(state.destination!),
          ),
        ],
        if (isRouteFetching) ...[
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 6,
              color: AppColors.info,
              backgroundColor: AppColors.grey200,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            MapConstants.routeLoadingMessage,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: buttonEnabled ? onTripAction : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: state.isTripActive
                  ? AppColors.secondary
                  : AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(buttonLabel),
          ),
        ),
      ],
    );
  }

  String _formatCoordinates(LatLng point) {
    return '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}';
  }
}

class _MapStatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _MapStatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _MapInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _MapInfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
