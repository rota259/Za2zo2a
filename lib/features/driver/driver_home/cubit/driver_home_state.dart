import 'package:equatable/equatable.dart';
import '../data/models/ride_request_model.dart';

abstract class DriverHomeState extends Equatable {
  const DriverHomeState();

  @override
  List<Object?> get props => [];
}

class DriverHomeInitial extends DriverHomeState {}

class DriverHomeLoading extends DriverHomeState {}

class DriverHomeOnline extends DriverHomeState {
  final bool isListening; // waiting for a request

  const DriverHomeOnline({this.isListening = true});

  @override
  List<Object?> get props => [isListening];
}

class DriverHomeOffline extends DriverHomeState {}

class DriverHomeRequestReceived extends DriverHomeState {
  final RideRequestModel request;

  const DriverHomeRequestReceived(this.request);

  @override
  List<Object?> get props => [request];
}

class DriverHomeRequestAccepted extends DriverHomeState {
  final RideRequestModel request;

  const DriverHomeRequestAccepted(this.request);

  @override
  List<Object?> get props => [request];
}

class DriverHomeError extends DriverHomeState {
  final String message;

  const DriverHomeError(this.message);

  @override
  List<Object?> get props => [message];
}
