import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class RouteEntity extends Equatable {
  final LatLng origin;
  final LatLng destination;
  final List<LatLng> points;
  final double distanceMeters;
  final double durationSeconds;
  final String turnInstruction;
  final double distanceToTurnMeters;

  const RouteEntity({
    required this.origin,
    required this.destination,
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.turnInstruction,
    required this.distanceToTurnMeters,
  });

  @override
  List<Object?> get props => [
    origin,
    destination,
    points,
    distanceMeters,
    durationSeconds,
    turnInstruction,
    distanceToTurnMeters,
  ];
}
