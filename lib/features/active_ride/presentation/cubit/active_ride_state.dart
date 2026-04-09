import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/driver_info_entity.dart';
import '../../domain/entities/route_entity.dart';

abstract class ActiveRideState extends Equatable {
  const ActiveRideState();

  @override
  List<Object?> get props => [];
}

class ActiveRideLoading extends ActiveRideState {
  const ActiveRideLoading();
}

class ActiveRideInProgress extends ActiveRideState {
  final RouteEntity route;
  final String turnInstruction;
  final double tripProgress;
  final DriverInfoEntity driverInfo;
  final String eta;
  final String distanceKm;
  final LatLng? destination;

  const ActiveRideInProgress({
    required this.route,
    required this.turnInstruction,
    required this.tripProgress,
    required this.driverInfo,
    required this.eta,
    required this.distanceKm,
    required this.destination,
  });

  @override
  List<Object?> get props => [
    route,
    turnInstruction,
    tripProgress,
    driverInfo,
    eta,
    distanceKm,
    destination,
  ];
}

class ActiveRideCompleted extends ActiveRideState {
  const ActiveRideCompleted();
}

class ActiveRideError extends ActiveRideState {
  final String message;

  const ActiveRideError(this.message);

  @override
  List<Object?> get props => [message];
}
