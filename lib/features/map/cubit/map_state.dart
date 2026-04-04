import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final LatLng currentLocation;
  final LatLng pickupLocation;
  final LatLng? destinationLocation;
  final bool isFindingDriver;
  final bool driverFound;
  final LatLng? driverLocation;

  const MapLoaded({
    required this.currentLocation,
    required this.pickupLocation,
    this.destinationLocation,
    this.isFindingDriver = false,
    this.driverFound = false,
    this.driverLocation,
  });

  MapLoaded copyWith({
    LatLng? currentLocation,
    LatLng? pickupLocation,
    LatLng? destinationLocation,
    bool? isFindingDriver,
    bool? driverFound,
    LatLng? driverLocation,
  }) {
    return MapLoaded(
      currentLocation: currentLocation ?? this.currentLocation,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      isFindingDriver: isFindingDriver ?? this.isFindingDriver,
      driverFound: driverFound ?? this.driverFound,
      driverLocation: driverLocation ?? this.driverLocation,
    );
  }

  @override
  List<Object?> get props => [
        currentLocation,
        pickupLocation,
        destinationLocation,
        isFindingDriver,
        driverFound,
        driverLocation,
      ];
}

class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object?> get props => [message];
}
