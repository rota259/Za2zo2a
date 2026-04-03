import 'package:latlong2/latlong.dart';

class RouteModel {
  final List<LatLng> polylinePoints;
  final double distance; // in meters
  final double duration; // in seconds

  RouteModel({
    required this.polylinePoints,
    required this.distance,
    required this.duration,
  });

  /// Factory constructor to parse OSRM route response
  factory RouteModel.fromJson(Map<String, dynamic> json) {
    List<LatLng> points = [];
    double dist = 0.0;
    double dur = 0.0;

    if (json['routes'] != null && (json['routes'] as List).isNotEmpty) {
      final route = json['routes'][0];
      dist = route['distance']?.toDouble() ?? 0.0;
      dur = route['duration']?.toDouble() ?? 0.0;

      if (route['geometry'] != null) {
        // OSRM returns geometry as GeoJSON (format=geojson)
        final coords = route['geometry']['coordinates'] as List;
        for (var coord in coords) {
          // GeoJSON is [longitude, latitude]
          points.add(LatLng(coord[1], coord[0]));
        }
      }
    }

    return RouteModel(polylinePoints: points, distance: dist, duration: dur);
  }
}
