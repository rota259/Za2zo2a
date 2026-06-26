import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String? currentLocation;
  final LatLng? currentLocationCoords;
  final String? selectedDestination;
  final LatLng? selectedDestinationCoords;
  final String? savedHomeAddress;
  final String? savedWorkAddress;

  const HomeLoaded({
    this.currentLocation,
    this.currentLocationCoords,
    this.selectedDestination,
    this.selectedDestinationCoords,
    this.savedHomeAddress,
    this.savedWorkAddress,
  });

  @override
  List<Object?> get props => [
    currentLocation,
    currentLocationCoords,
    selectedDestination,
    selectedDestinationCoords,
    savedHomeAddress,
    savedWorkAddress,
  ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
