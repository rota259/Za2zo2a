import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/search_result_model.dart';
import '../../viewmodel/map_state.dart';
import 'map_location_info_content.dart';

class MapDetailsPanel extends StatelessWidget {
  final MapLocationLoaded state;
  final SearchResultModel? destinationDetails;
  final bool isRouteFetching;
  final VoidCallback onTripAction;

  const MapDetailsPanel({
    super.key,
    required this.state,
    required this.destinationDetails,
    required this.isRouteFetching,
    required this.onTripAction,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.grey50,
      child: SafeArea(
        left: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 18,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: MapLocationInfoContent(
                state: state,
                destinationDetails: destinationDetails,
                isRouteFetching: isRouteFetching,
                onTripAction: onTripAction,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
