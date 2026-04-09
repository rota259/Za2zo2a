class AppConstants {
  static const searchDebounce = Duration(milliseconds: 400);
  static const routeRefreshInterval = Duration(seconds: 10);
  static const routeRetryDelay = Duration(seconds: 5);
  static const initialMapZoom = 15.0;
  static const minZoom = 5.0;
  static const maxZoom = 18.0;
  static const osmTileUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const tileUserAgentPackageName = 'com.voltride.app';
  static const searchResultLimit = 10;
  static const nominatimCountryCode = 'eg';
  static const tabletBreakpoint = 900.0;
  static const homeMapHeightFactor = 0.45;
  static const rideMapHeightFactor = 0.5;
  static const mapAnimationDuration = Duration(milliseconds: 450);
}
