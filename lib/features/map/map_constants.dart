class MapConstants {
  const MapConstants._();

  static const String googleTileUrl =
      'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}';
  static const List<String> googleTileSubdomains = ['mt0', 'mt1', 'mt2', 'mt3'];
  static const String userAgentPackageName = 'com.za2zo2a.app';
  static const String nominatimUserAgent =
      'za2zo2a-map-feature/1.0 (contact: support@za2zo2a.app)';
  static const String nominatimHost = 'nominatim.openstreetmap.org';
  static const String nominatimPath = '/search';
  static const String osrmRouteBaseUrl =
      'https://router.project-osrm.org/route/v1/driving';

  static const String searchHint = 'Search destination';
  static const String searchUnavailableMessage =
      'Search unavailable, try again';
  static const String routeUnavailableMessage =
      'Could not load route, check internet';
  static const String locationLoadingMessage = 'Finding your live location...';
  static const String routeLoadingMessage = 'Updating route...';
  static const String mapUnavailableTitle = 'Location unavailable';
  static const String mapUnavailableDescription =
      'We could not load your current location right now.';
  static const String retryLabel = 'Retry';
  static const String cancelLabel = 'Cancel';
  static const String openSettingsLabel = 'Open settings';
  static const String enableGpsLabel = 'Enable GPS';
  static const String routePanelTitle = 'Trip details';
  static const String noDestinationTitle = 'Choose a destination';
  static const String noDestinationDescription =
      'Search for a place to place a destination pin and build a driving route.';
  static const String currentLocationLabel = 'Current location';
  static const String destinationLabel = 'Destination';
  static const String distanceLabel = 'Distance';
  static const String durationLabel = 'ETA';
  static const String followStatusOnLabel = 'Tracking on';
  static const String followStatusOffLabel = 'Tracking paused';
  static const String startTripLabel = 'Start Trip';
  static const String endTripLabel = 'End Trip';
  static const String navigateLabel = 'Navigate';
  static const String searchingLabel = 'Searching...';
  static const String noDistanceValue = '--';
  static const String noDurationValue = '--';
  static const String selectedDestinationFallback = 'Selected destination';
  static const String tripReadyLabel = 'Route ready';
  static const String routePendingLabel = 'Route pending';
  static const String centerLocationTooltip = 'Center on my location';
  static const String resumeTrackingTooltip = 'Resume live tracking';
  static const String zoomInTooltip = 'Zoom in';
  static const String zoomOutTooltip = 'Zoom out';
  static const String permissionDialogTitle = 'Location permission needed';
  static const String permissionDialogMessage =
      'We need location access to show your real-time position on the map.';
  static const String gpsDialogTitle = 'Enable GPS';
  static const String gpsDialogMessage =
      'Location services are turned off. Enable GPS to continue tracking your trip.';
  static const String timeoutDialogTitle = 'Location timed out';
  static const String timeoutDialogMessage =
      'We could not get your location in time. Please try again.';
  static const String locationServicesDisabledMessage =
      'Location services are disabled.';
  static const String permissionDeniedMessage =
      'Location permission was denied.';
  static const String permissionDeniedForeverMessage =
      'Location permission is permanently denied.';
  static const String locationTimeoutMessage = 'Location request timed out.';
  static const String unexpectedLocationErrorMessage =
      'Unable to fetch your current location right now.';
  static const String noDestinationSelectedMessage =
      'Select a destination before starting navigation.';
  static const String navigationUnavailableMessage =
      'Unable to open navigation right now.';
  static const String searchFieldSemanticLabel = 'Destination search';

  static const double initialZoom = 15;
  static const double minZoom = 3;
  static const double maxZoom = 18.5;
  static const double zoomStep = 1;
  static const double mobileSheetHeight = 238;
  static const double mobileMapBottomInset = 224;
  static const double tabletPanelWidth = 360;
  static const double routeRefreshThresholdMeters = 50;
  static const int searchResultLimit = 5;

  static const Duration locationTimeout = Duration(seconds: 60);
  static const Duration apiTimeout = Duration(seconds: 10);
  static const Duration searchDebounce = Duration(milliseconds: 450);
  static const Duration routeRefreshCooldown = Duration(seconds: 15);
}
