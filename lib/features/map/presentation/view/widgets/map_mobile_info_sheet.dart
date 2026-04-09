import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/search_result_model.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_state.dart';
import 'map_location_info_content.dart';

class MapMobileInfoSheet extends StatelessWidget {
  final MapLocationLoaded state;
  final SearchResultModel? destinationDetails;
  final bool isRouteFetching;
  final VoidCallback onTripAction;

  const MapMobileInfoSheet({
    super.key,
    required this.state,
    required this.destinationDetails,
    required this.isRouteFetching,
    required this.onTripAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MapConstants.mobileSheetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: MapLocationInfoContent(
                state: state,
                destinationDetails: destinationDetails,
                isRouteFetching: isRouteFetching,
                onTripAction: onTripAction,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
