import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/search_result_model.dart';

class MapSearchResultsList extends StatelessWidget {
  final List<SearchResultModel> results;
  final ValueChanged<SearchResultModel> onSelected;

  const MapSearchResultsList({
    super.key,
    required this.results,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      shadowColor: Colors.black.withValues(alpha: 0.12),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 280),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: results.length,
          separatorBuilder: (context, index) =>
              Divider(height: 1, thickness: 1, color: AppColors.grey200),
          itemBuilder: (context, index) {
            final result = results[index];

            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.blueTint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.place_outlined, color: AppColors.info),
              ),
              title: Text(
                result.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                result.displayName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColors.textSecondary, height: 1.3),
              ),
              onTap: () => onSelected(result),
            );
          },
        ),
      ),
    );
  }
}
