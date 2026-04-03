import 'package:equatable/equatable.dart';
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

  const DriverHeadingToPickup({required this.trip, this.remainingMinutes = 5});

  @override
  List<Object?> get props => [trip, remainingMinutes];
}

// Rider picked up – trip in progress
class DriverTripInProgress extends DriverTripState {
  final DriverTripModel trip;
  final int remainingMinutes;

  const DriverTripInProgress({required this.trip, this.remainingMinutes = 18});

  @override
  List<Object?> get props => [trip, remainingMinutes];
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
