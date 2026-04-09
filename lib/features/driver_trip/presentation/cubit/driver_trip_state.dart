import 'package:equatable/equatable.dart';

import '../../../active_ride/domain/entities/route_entity.dart';
import '../../domain/entities/destination_entity.dart';

abstract class DriverTripState extends Equatable {
  const DriverTripState();

  @override
  List<Object?> get props => [];
}

class DriverTripLoading extends DriverTripState {
  const DriverTripLoading();
}

class DriverTripActive extends DriverTripState {
  final RouteEntity route;
  final String turnInstruction;
  final String distanceToTurn;
  final String eta;
  final DestinationEntity destination;
  final String distanceKm;
  final String tripTime;

  const DriverTripActive({
    required this.route,
    required this.turnInstruction,
    required this.distanceToTurn,
    required this.eta,
    required this.destination,
    required this.distanceKm,
    required this.tripTime,
  });

  @override
  List<Object?> get props => [
    route,
    turnInstruction,
    distanceToTurn,
    eta,
    destination,
    distanceKm,
    tripTime,
  ];
}

class DriverTripEnded extends DriverTripState {
  const DriverTripEnded();
}

class DriverTripError extends DriverTripState {
  final String message;

  const DriverTripError(this.message);

  @override
  List<Object?> get props => [message];
}
