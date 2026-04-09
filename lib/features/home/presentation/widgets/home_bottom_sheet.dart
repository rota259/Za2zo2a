import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/models/nominatim_place_model.dart';
import 'home_search_bar.dart';
import 'home_search_results_list.dart';
import 'quick_chips_row.dart';
import 'request_ride_button.dart';
import 'ride_card_widget.dart';

class HomeBottomSheet extends StatelessWidget {
  final bool isTablet;
  final TextEditingController controller;
  final bool isSearchLoading;
  final bool isSearchEmpty;
  final bool showResults;
  final List<NominatimPlaceModel> results;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ValueChanged<NominatimPlaceModel> onPlaceSelected;
  final ValueChanged<String> onQuickChipSelected;
  final VoidCallback onRequestRide;

  const HomeBottomSheet({
    super.key,
    required this.isTablet,
    required this.controller,
    required this.isSearchLoading,
    required this.isSearchEmpty,
    required this.showResults,
    required this.results,
    required this.onChanged,
    required this.onClear,
    required this.onPlaceSelected,
    required this.onQuickChipSelected,
    required this.onRequestRide,
  });

  @override
  Widget build(BuildContext context) {
    final radius = isTablet
        ? const BorderRadius.only(topLeft: Radius.circular(24))
        : const BorderRadius.vertical(top: Radius.circular(24));

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: radius,
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        children: [
          HomeSearchBar(
            controller: controller,
            onChanged: onChanged,
            onClear: onClear,
          ),
          if (showResults)
            HomeSearchResultsList(
              isLoading: isSearchLoading,
              isEmpty: isSearchEmpty,
              results: results,
              onSelected: onPlaceSelected,
            ),
          const SizedBox(height: 16),
          QuickChipsRow(onSelected: onQuickChipSelected),
          const SizedBox(height: 20),
          Text(
            AppStrings.recommendedRide,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.greyText,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const RideCardWidget(),
          const SizedBox(height: 20),
          RequestRideButton(onPressed: onRequestRide),
        ],
      ),
    );
  }
}
