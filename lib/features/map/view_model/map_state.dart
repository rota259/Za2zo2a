import 'package:latlong2/latlong.dart';
import '../model/route_model.dart';
import 'package:equatable/equatable.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {
  final String message;
  const MapLoading(this.message);

  @override
  List<Object?> get props => [message];
}

class MapReady extends MapState {
  final LatLng userLocation;
  final LatLng? destination;
  final RouteModel? route;
  final LatLng? driverMockLocation;

  const MapReady({
    required this.userLocation,
    this.destination,
    this.route,
    this.driverMockLocation,
  });

  MapReady copyWith({
    LatLng? userLocation,
    LatLng? destination,
    RouteModel? route,
    LatLng? driverMockLocation,
    bool clearDestination = false,
  }) {
    return MapReady(
      userLocation: userLocation ?? this.userLocation,
      destination: clearDestination ? null : (destination ?? this.destination),
      route: clearDestination ? null : (route ?? this.route),
      driverMockLocation: driverMockLocation ?? this.driverMockLocation,
    );
  }

  @override
  List<Object?> get props => [
    userLocation,
    destination,
    route,
    driverMockLocation,
  ];
}

class MapError extends MapState {
  final String error;
  const MapError(this.error);

  @override
  List<Object?> get props => [error];
}
