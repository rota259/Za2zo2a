import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import '../data/models/ride_request_model.dart';

abstract class DriverHomeState extends Equatable {
  final LatLng? currentLocationCoords;
  const DriverHomeState({this.currentLocationCoords});

  @override
  List<Object?> get props => [currentLocationCoords];
}

class DriverHomeInitial extends DriverHomeState {}

class DriverHomeLoading extends DriverHomeState {}

class DriverHomeOnline extends DriverHomeState {
  final bool isListening;

  const DriverHomeOnline({
    this.isListening = true,
    super.currentLocationCoords,
  });

  @override
  List<Object?> get props => [isListening, currentLocationCoords];
}

class DriverHomeOffline extends DriverHomeState {
  const DriverHomeOffline({super.currentLocationCoords});
}

class DriverHomeRequestReceived extends DriverHomeState {
  final RideRequestModel request;

  const DriverHomeRequestReceived(this.request, {super.currentLocationCoords});

  @override
  List<Object?> get props => [request, currentLocationCoords];
}

class DriverHomeRequestAccepted extends DriverHomeState {
  final RideRequestModel request;

  const DriverHomeRequestAccepted(this.request, {super.currentLocationCoords});

  @override
  List<Object?> get props => [request, currentLocationCoords];
}

class DriverHomeError extends DriverHomeState {
  final String message;

  const DriverHomeError(this.message, {super.currentLocationCoords});

  @override
  List<Object?> get props => [message, currentLocationCoords];
}
