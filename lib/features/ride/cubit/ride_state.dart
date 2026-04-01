import 'package:equatable/equatable.dart';
import '../data/models/ride_model.dart';

abstract class RideState extends Equatable {
  const RideState();

  @override
  List<Object?> get props => [];
}

class RideInitial extends RideState {}

class RideLoading extends RideState {}

class RideOptionsLoaded extends RideState {
  final List<RideModel> rides;
  
  const RideOptionsLoaded(this.rides);

  @override
  List<Object?> get props => [rides];
}

class RideActive extends RideState {
  final RideModel activeRide;
  
  const RideActive(this.activeRide);

  @override
  List<Object?> get props => [activeRide];
}

class RideCompleted extends RideState {
  final RideModel completedRide;

  const RideCompleted(this.completedRide);

  @override
  List<Object?> get props => [completedRide];
}

class RideError extends RideState {
  final String message;

  const RideError(this.message);

  @override
  List<Object?> get props => [message];
}
