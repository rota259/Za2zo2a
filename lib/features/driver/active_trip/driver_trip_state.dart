import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../trip/data/models/trip_models.dart';

class DriverTripState extends Equatable {
  final TripModel? trip;
  final LatLng? driverLocation;

  /// Route polyline driver → pickup (from /api/map/route).
  final List<LatLng> headingRoute;

  final bool loading;

  /// Driver tapped "Arrived" — reveals the PIN entry.
  final bool arrived;

  final bool actionInFlight;

  /// Error specific to PIN entry (wrong pin) — keeps the field, allows retry.
  final String? pinError;

  final String? error;

  const DriverTripState({
    this.trip,
    this.driverLocation,
    this.headingRoute = const [],
    this.loading = true,
    this.arrived = false,
    this.actionInFlight = false,
    this.pinError,
    this.error,
  });

  TripStatus get status => trip?.status ?? TripStatus.accepted;

  DriverTripState copyWith({
    TripModel? trip,
    LatLng? driverLocation,
    List<LatLng>? headingRoute,
    bool? loading,
    bool? arrived,
    bool? actionInFlight,
    String? pinError,
    bool clearPinError = false,
    String? error,
    bool clearError = false,
  }) {
    return DriverTripState(
      trip: trip ?? this.trip,
      driverLocation: driverLocation ?? this.driverLocation,
      headingRoute: headingRoute ?? this.headingRoute,
      loading: loading ?? this.loading,
      arrived: arrived ?? this.arrived,
      actionInFlight: actionInFlight ?? this.actionInFlight,
      pinError: clearPinError ? null : (pinError ?? this.pinError),
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [
    trip?.id,
    trip?.status,
    driverLocation,
    headingRoute.length,
    loading,
    arrived,
    actionInFlight,
    pinError,
    error,
  ];
}
