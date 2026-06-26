import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../trip/data/models/trip_models.dart';

class DriverDispatchState extends Equatable {
  final bool isOnline;
  final bool toggling;
  final bool loadingTrips;

  /// Open trips, already sorted nearest-first by driver GPS.
  final List<TripModel> trips;
  final LatLng? driverLocation;

  /// Trip ids whose accept request is in flight (button disabled).
  final Set<String> acceptingIds;

  /// Set when an accept succeeds — the screen navigates to the active trip.
  final TripModel? acceptedTrip;

  /// Transient message (errors, "trip already taken").
  final String? message;

  const DriverDispatchState({
    this.isOnline = false,
    this.toggling = false,
    this.loadingTrips = false,
    this.trips = const [],
    this.driverLocation,
    this.acceptingIds = const {},
    this.acceptedTrip,
    this.message,
  });

  DriverDispatchState copyWith({
    bool? isOnline,
    bool? toggling,
    bool? loadingTrips,
    List<TripModel>? trips,
    LatLng? driverLocation,
    Set<String>? acceptingIds,
    TripModel? acceptedTrip,
    bool clearAccepted = false,
    String? message,
    bool clearMessage = false,
  }) {
    return DriverDispatchState(
      isOnline: isOnline ?? this.isOnline,
      toggling: toggling ?? this.toggling,
      loadingTrips: loadingTrips ?? this.loadingTrips,
      trips: trips ?? this.trips,
      driverLocation: driverLocation ?? this.driverLocation,
      acceptingIds: acceptingIds ?? this.acceptingIds,
      acceptedTrip: clearAccepted ? null : (acceptedTrip ?? this.acceptedTrip),
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [
    isOnline,
    toggling,
    loadingTrips,
    trips.map((t) => t.id).toList(),
    driverLocation,
    acceptingIds,
    acceptedTrip?.id,
    message,
  ];
}
