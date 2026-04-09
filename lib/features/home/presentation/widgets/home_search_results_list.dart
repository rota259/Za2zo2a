import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/models/nominatim_place_model.dart';

class HomeSearchResultsList extends StatelessWidget {
  final bool isLoading;
  final bool isEmpty;
  final List<NominatimPlaceModel> results;
  final ValueChanged<NominatimPlaceModel> onSelected;

  const HomeSearchResultsList({
    super.key,
    required this.isLoading,
    required this.isEmpty,
    required this.results,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 12),
        child: LinearProgressIndicator(minHeight: 3),
      );
    }

    if (isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          AppStrings.noResults,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.greyText),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: results.length,
        separatorBuilder: (_, index) =>
            Divider(height: 1, color: AppColors.grey200),
        itemBuilder: (context, index) {
          final place = results[index];
          return ListTile(
            onTap: () => onSelected(place),
            leading: Icon(Icons.place_outlined, color: AppColors.primary),
            title: Text(
              place.placeName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              place.shortAddress,
              style: TextStyle(color: AppColors.greyText),
            ),
          );
        },
      ),
    );
  }
}
