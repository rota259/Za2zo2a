import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../map_constants.dart';

class MapSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isSearching;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const MapSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isSearching,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 8,
      borderRadius: BorderRadius.circular(18),
      shadowColor: Colors.black.withValues(alpha: 0.15),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: MapConstants.searchHint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          suffixIcon: isSearching
              ? Padding(
                  padding: const EdgeInsets.all(14),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: AppColors.primary,
                    ),
                  ),
                )
              : controller.text.trim().isNotEmpty
              ? IconButton(
                  tooltip: MapConstants.cancelLabel,
                  icon: Icon(Icons.close_rounded, color: AppColors.primary),
                  onPressed: onClear,
                )
              : const Icon(Icons.place_outlined, color: Colors.black45),
        ),
      ),
    );
  }
}
