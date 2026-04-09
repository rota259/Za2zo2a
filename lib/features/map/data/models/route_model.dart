import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class RouteModel extends Equatable {
  final List<LatLng> points;
  final double distanceMeters;
  final int durationSeconds;

  const RouteModel({
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
  });

  factory RouteModel.fromOsrm(Map<String, dynamic> json) {
    final routes = json['routes'];
    if (routes is! List || routes.isEmpty) {
      throw const FormatException('No route found');
    }

    final route = routes.first;
    if (route is! Map<String, dynamic>) {
      throw const FormatException('Invalid route payload');
    }

    final geometry = route['geometry'];
    if (geometry is! Map<String, dynamic>) {
      throw const FormatException('Missing route geometry');
    }

    final coordinates = geometry['coordinates'];
    if (coordinates is! List || coordinates.isEmpty) {
      throw const FormatException('No route coordinates found');
    }

    final points = coordinates
        .map((coordinate) {
          if (coordinate is! List || coordinate.length < 2) {
            throw const FormatException('Invalid coordinate pair');
          }

          final lon = (coordinate[0] as num).toDouble();
          final lat = (coordinate[1] as num).toDouble();
          return LatLng(lat, lon);
        })
        .toList(growable: false);

    return RouteModel(
      points: points,
      distanceMeters: (route['distance'] as num?)?.toDouble() ?? 0,
      durationSeconds: ((route['duration'] as num?)?.toDouble() ?? 0).round(),
    );
  }

  @override
  List<Object?> get props => [points, distanceMeters, durationSeconds];
}
