import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/route_entity.dart';

class OsrmRouteModel extends RouteEntity {
  const OsrmRouteModel({
    required super.origin,
    required super.destination,
    required super.points,
    required super.distanceMeters,
    required super.durationSeconds,
    required super.turnInstruction,
    required super.distanceToTurnMeters,
  });

  factory OsrmRouteModel.fromJson(
    Map<String, dynamic> json, {
    required LatLng origin,
    required LatLng destination,
  }) {
    final routes = (json['routes'] as List<dynamic>? ?? const []);
    final route = (routes.firstOrNull as Map?)?.cast<String, dynamic>() ?? {};
    final geometry = (route['geometry'] as Map?)?.cast<String, dynamic>() ?? {};
    final coordinates = geometry['coordinates'] as List<dynamic>? ?? const [];
    final legs = route['legs'] as List<dynamic>? ?? const [];
    final firstLeg = (legs.firstOrNull as Map?)?.cast<String, dynamic>() ?? {};
    final steps = firstLeg['steps'] as List<dynamic>? ?? const [];
    final firstStep =
        (steps.firstOrNull as Map?)?.cast<String, dynamic>() ?? {};
    final maneuver =
        (firstStep['maneuver'] as Map?)?.cast<String, dynamic>() ?? {};

    return OsrmRouteModel(
      origin: origin,
      destination: destination,
      points: coordinates
          .whereType<List<dynamic>>()
          .where((item) => item.length >= 2)
          .map(
            (item) => LatLng(
              (item[1] as num).toDouble(),
              (item[0] as num).toDouble(),
            ),
          )
          .toList(growable: false),
      distanceMeters: (firstLeg['distance'] as num?)?.toDouble() ?? 0,
      durationSeconds: (firstLeg['duration'] as num?)?.toDouble() ?? 0,
      turnInstruction:
          '${maneuver['instruction'] ?? AppStrings.defaultTurnInstruction}',
      distanceToTurnMeters: (firstStep['distance'] as num?)?.toDouble() ?? 0,
    );
  }
}

extension on List<dynamic> {
  dynamic get firstOrNull => isEmpty ? null : first;
}
