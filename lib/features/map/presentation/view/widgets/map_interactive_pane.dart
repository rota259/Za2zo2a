import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../data/models/search_result_model.dart';
import '../../viewmodel/map_state.dart';
import 'map_canvas.dart';
import 'map_floating_actions.dart';
import 'map_search_bar.dart';
import 'map_search_results_list.dart';

class MapInteractivePane extends StatelessWidget {
  final MapLocationLoaded state;
  final MapController mapController;
  final double bottomInset;
  final bool showSearchBar;
  final bool showMapControls;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final List<SearchResultModel> searchResults;
  final bool isSearching;
  final bool showNavigateButton;
  final VoidCallback onMapTap;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;
  final ValueChanged<SearchResultModel> onSuggestionSelected;
  final VoidCallback onNavigate;
  final VoidCallback onCenterOnUserLocation;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final void Function(MapPosition position, bool hasGesture) onPositionChanged;

  const MapInteractivePane({
    super.key,
    required this.state,
    required this.mapController,
    required this.bottomInset,
    required this.showSearchBar,
    required this.showMapControls,
    required this.searchController,
    required this.searchFocusNode,
    required this.searchResults,
    required this.isSearching,
    required this.showNavigateButton,
    required this.onMapTap,
    required this.onSearchChanged,
    required this.onSearchCleared,
    required this.onSuggestionSelected,
    required this.onNavigate,
    required this.onCenterOnUserLocation,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: MapCanvas(
            state: state,
            mapController: mapController,
            onMapTap: onMapTap,
            onPositionChanged: onPositionChanged,
          ),
        ),
        if (showSearchBar)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    MapSearchBar(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      isSearching: isSearching,
                      onChanged: onSearchChanged,
                      onClear: onSearchCleared,
                    ),
                    if (searchResults.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      MapSearchResultsList(
                        results: searchResults,
                        onSelected: onSuggestionSelected,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        if (showMapControls)
          Positioned(
            right: 16,
            bottom: bottomInset,
            child: SafeArea(
              top: false,
              left: false,
              child: MapFloatingActions(
                isFollowingUser: state.isFollowingUser,
                showNavigateButton:
                    showNavigateButton &&
                    state.isTripActive &&
                    state.destination != null,
                onNavigate: onNavigate,
                onCenterOnUserLocation: onCenterOnUserLocation,
                onZoomIn: onZoomIn,
                onZoomOut: onZoomOut,
              ),
            ),
          ),
      ],
    );
  }
}
