import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../../active_ride/domain/entities/route_entity.dart';
import '../data/models/driver_trip_model.dart';

abstract class DriverTripState extends Equatable {
  const DriverTripState();

  @override
  List<Object?> get props => [];
}

class DriverTripInitial extends DriverTripState {}

class DriverTripLoading extends DriverTripState {}

// Driver heading to pickup location
class DriverHeadingToPickup extends DriverTripState {
  final DriverTripModel trip;
  final int remainingMinutes;
  final RouteEntity? route;
  final String? turnInstruction;
  final String? distanceToTurn;
  final String? eta;

  const DriverHeadingToPickup({
    required this.trip,
    this.remainingMinutes = 5,
    this.route,
    this.turnInstruction,
    this.distanceToTurn,
    this.eta,
  });

  DriverHeadingToPickup copyWithRoute({
    RouteEntity? route,
    String? turnInstruction,
    String? distanceToTurn,
    String? eta,
  }) {
    return DriverHeadingToPickup(
      trip: trip,
      remainingMinutes: remainingMinutes,
      route: route ?? this.route,
      turnInstruction: turnInstruction ?? this.turnInstruction,
      distanceToTurn: distanceToTurn ?? this.distanceToTurn,
      eta: eta ?? this.eta,
    );
  }

  /// Current target for the driver (pickup point)
  LatLng? get targetLocation =>
      (trip.pickupLat != 0.0 && trip.pickupLng != 0.0)
          ? LatLng(trip.pickupLat, trip.pickupLng)
          : null;

  @override
  List<Object?> get props => [
    trip,
    remainingMinutes,
    route,
    turnInstruction,
    distanceToTurn,
    eta,
  ];
}

// Rider picked up – trip in progress
class DriverTripInProgress extends DriverTripState {
  final DriverTripModel trip;
  final int remainingMinutes;
  final RouteEntity? route;
  final String? turnInstruction;
  final String? distanceToTurn;
  final String? eta;

  const DriverTripInProgress({
    required this.trip,
    this.remainingMinutes = 18,
    this.route,
    this.turnInstruction,
    this.distanceToTurn,
    this.eta,
  });

  DriverTripInProgress copyWithRoute({
    RouteEntity? route,
    String? turnInstruction,
    String? distanceToTurn,
    String? eta,
  }) {
    return DriverTripInProgress(
      trip: trip,
      remainingMinutes: remainingMinutes,
      route: route ?? this.route,
      turnInstruction: turnInstruction ?? this.turnInstruction,
      distanceToTurn: distanceToTurn ?? this.distanceToTurn,
      eta: eta ?? this.eta,
    );
  }

  /// Current target for the driver (destination point)
  LatLng? get targetLocation =>
      (trip.destinationLat != 0.0 && trip.destinationLng != 0.0)
          ? LatLng(trip.destinationLat, trip.destinationLng)
          : null;

  @override
  List<Object?> get props => [
    trip,
    remainingMinutes,
    route,
    turnInstruction,
    distanceToTurn,
    eta,
  ];
}

// Trip completed – show summary
class DriverTripCompleted extends DriverTripState {
  final DriverTripModel trip;

  const DriverTripCompleted(this.trip);

  @override
  List<Object?> get props => [trip];
}

// Trip history loaded
class DriverTripHistoryLoaded extends DriverTripState {
  final List<DriverTripModel> trips;

  const DriverTripHistoryLoaded(this.trips);

  @override
  List<Object?> get props => [trips];
}

class DriverTripError extends DriverTripState {
  final String message;

  const DriverTripError(this.message);

  @override
  List<Object?> get props => [message];
}
