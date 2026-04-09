import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/search_result_model.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

final class MapInitial extends MapState {
  const MapInitial();
}

final class MapLocationLoading extends MapState {
  const MapLocationLoading();
}

final class MapLocationLoaded extends MapState {
  final LatLng userLocation;
  final LatLng? destination;
  final List<LatLng> routePoints;
  final String? distanceText;
  final String? durationText;
  final bool isTripActive;
  final bool isFollowingUser;

  const MapLocationLoaded({
    required this.userLocation,
    required this.destination,
    required this.routePoints,
    required this.distanceText,
    required this.durationText,
    required this.isTripActive,
    required this.isFollowingUser,
  });

  static const Object _unset = Object();

  MapLocationLoaded copyWith({
    LatLng? userLocation,
    Object? destination = _unset,
    List<LatLng>? routePoints,
    Object? distanceText = _unset,
    Object? durationText = _unset,
    bool? isTripActive,
    bool? isFollowingUser,
  }) {
    return MapLocationLoaded(
      userLocation: userLocation ?? this.userLocation,
      destination: identical(destination, _unset)
          ? this.destination
          : destination as LatLng?,
      routePoints: routePoints ?? this.routePoints,
      distanceText: identical(distanceText, _unset)
          ? this.distanceText
          : distanceText as String?,
      durationText: identical(durationText, _unset)
          ? this.durationText
          : durationText as String?,
      isTripActive: isTripActive ?? this.isTripActive,
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    );
  }

  @override
  List<Object?> get props => [
    userLocation,
    destination,
    routePoints,
    distanceText,
    durationText,
    isTripActive,
    isFollowingUser,
  ];
}

final class MapSearching extends MapState {
  const MapSearching();
}

final class MapSearchResults extends MapState {
  final List<SearchResultModel> results;

  const MapSearchResults(this.results);

  @override
  List<Object?> get props => [results];
}

final class MapRouteFetching extends MapState {
  const MapRouteFetching();
}

final class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object?> get props => [message];
}
