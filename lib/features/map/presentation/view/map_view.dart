import 'package:flutter/material.dart';
import 'widgets/map_view_content.dart';

class MapView extends StatelessWidget {
  final bool showScaffold;
  final bool showSearchBar;
  final bool showLocationDetails;
  final bool showMapControls;
  final bool allowMarkerCreation;

  const MapView({
    super.key,
    this.showScaffold = true,
    this.showSearchBar = true,
    this.showLocationDetails = true,
    this.showMapControls = true,
    this.allowMarkerCreation = true,
  });

  const MapView.embedded({
    super.key,
    this.showScaffold = false,
    this.showSearchBar = false,
    this.showLocationDetails = false,
    this.showMapControls = false,
    this.allowMarkerCreation = false,
  });

  @override
  Widget build(BuildContext context) {
    return MapViewContent(
      showScaffold: showScaffold,
      showSearchBar: showSearchBar,
      showLocationDetails: showLocationDetails,
      showMapControls: showMapControls,
      allowMarkerCreation: allowMarkerCreation,
    );
  }
}
