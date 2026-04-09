import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../data/models/search_result_model.dart';
import '../../viewmodel/map_state.dart';
import 'map_details_panel.dart';
import 'map_interactive_pane.dart';

class MapTabletLayout extends StatelessWidget {
  final MapLocationLoaded state;
  final MapController mapController;
  final bool showSearchBar;
  final bool showMapControls;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final List<SearchResultModel> searchResults;
  final SearchResultModel? destinationDetails;
  final bool isSearching;
  final bool isRouteFetching;
  final VoidCallback onMapTap;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;
  final ValueChanged<SearchResultModel> onSuggestionSelected;
  final VoidCallback onNavigate;
  final VoidCallback onCenterOnUserLocation;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onTripAction;
  final void Function(MapPosition position, bool hasGesture) onPositionChanged;

  const MapTabletLayout({
    super.key,
    required this.state,
    required this.mapController,
    required this.showSearchBar,
    required this.showMapControls,
    required this.searchController,
    required this.searchFocusNode,
    required this.searchResults,
    required this.destinationDetails,
    required this.isSearching,
    required this.isRouteFetching,
    required this.onMapTap,
    required this.onSearchChanged,
    required this.onSearchCleared,
    required this.onSuggestionSelected,
    required this.onNavigate,
    required this.onCenterOnUserLocation,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onTripAction,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: MapInteractivePane(
            state: state,
            mapController: mapController,
            bottomInset: 16,
            showSearchBar: showSearchBar,
            showMapControls: showMapControls,
            searchController: searchController,
            searchFocusNode: searchFocusNode,
            searchResults: searchResults,
            isSearching: isSearching,
            showNavigateButton: true,
            onMapTap: onMapTap,
            onSearchChanged: onSearchChanged,
            onSearchCleared: onSearchCleared,
            onSuggestionSelected: onSuggestionSelected,
            onNavigate: onNavigate,
            onPositionChanged: onPositionChanged,
            onCenterOnUserLocation: onCenterOnUserLocation,
            onZoomIn: onZoomIn,
            onZoomOut: onZoomOut,
          ),
        ),
        Expanded(
          flex: 1,
          child: MapDetailsPanel(
            state: state,
            destinationDetails: destinationDetails,
            isRouteFetching: isRouteFetching,
            onTripAction: onTripAction,
          ),
        ),
      ],
    );
  }
}
