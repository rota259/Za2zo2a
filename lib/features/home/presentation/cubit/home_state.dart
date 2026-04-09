import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/nominatim_place_model.dart';
import '../../domain/entities/place_entity.dart';

abstract class HomeState extends Equatable {
  final LatLng? userLocation;
  final LatLng? selectedLocation;
  final PlaceEntity? selectedPlace;
  final List<NominatimPlaceModel> results;
  final String query;

  const HomeState({
    this.userLocation,
    this.selectedLocation,
    this.selectedPlace,
    this.results = const [],
    this.query = '',
  });

  @override
  List<Object?> get props => [
    userLocation,
    selectedLocation,
    selectedPlace,
    results,
    query,
  ];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLocationLoading extends HomeState {
  const HomeLocationLoading({
    super.userLocation,
    super.selectedLocation,
    super.selectedPlace,
    super.results,
    super.query,
  });
}

class HomeLocationLoaded extends HomeState {
  const HomeLocationLoaded({
    required LatLng userLocation,
    super.selectedLocation,
    super.selectedPlace,
    super.results,
    super.query,
  }) : super(userLocation: userLocation);
}

class HomeSearchLoading extends HomeState {
  const HomeSearchLoading({
    super.userLocation,
    super.selectedLocation,
    super.selectedPlace,
    super.results,
    super.query,
  });
}

class HomeSearchLoaded extends HomeState {
  const HomeSearchLoaded({
    required super.results,
    super.userLocation,
    super.selectedLocation,
    super.selectedPlace,
    super.query,
  });
}

class HomeSearchError extends HomeState {
  final String message;

  const HomeSearchError(
    this.message, {
    super.userLocation,
    super.selectedLocation,
    super.selectedPlace,
    super.results,
    super.query,
  });

  @override
  List<Object?> get props => [...super.props, message];
}

class HomeSearchEmpty extends HomeState {
  const HomeSearchEmpty({
    super.userLocation,
    super.selectedLocation,
    super.selectedPlace,
    super.query,
  });
}

class HomeLocationError extends HomeState {
  final String message;
  final bool openSettings;

  const HomeLocationError(
    this.message, {
    required this.openSettings,
    super.selectedLocation,
    super.selectedPlace,
    super.results,
    super.query,
  });

  @override
  List<Object?> get props => [...super.props, message, openSettings];
}
