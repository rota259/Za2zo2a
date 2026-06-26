import 'package:equatable/equatable.dart';

import '../../../auth/data/models/auth_model.dart';
import '../../data/models/trip_models.dart';

class TripTrackingState extends Equatable {
  /// Latest trip snapshot from polling (null until first fetch).
  final TripModel? trip;

  /// Assigned driver profile (loaded once the trip is accepted).
  final UserModel? driver;

  final bool loadingInitial;

  /// True once we've waited past the no-driver threshold while still in
  /// `requested` — drives the "no drivers found" retry/cancel UI.
  final bool searchTimedOut;

  /// A cancel/rate action is in flight (disables the button).
  final bool actionInFlight;

  /// Transient error message (e.g. a failed poll/cancel), shown in a banner.
  final String? error;

  /// Set after the rider has submitted a rating.
  final bool rated;

  const TripTrackingState({
    this.trip,
    this.driver,
    this.loadingInitial = true,
    this.searchTimedOut = false,
    this.actionInFlight = false,
    this.error,
    this.rated = false,
  });

  TripStatus get status => trip?.status ?? TripStatus.requested;

  TripTrackingState copyWith({
    TripModel? trip,
    UserModel? driver,
    bool? loadingInitial,
    bool? searchTimedOut,
    bool? actionInFlight,
    String? error,
    bool clearError = false,
    bool? rated,
  }) {
    return TripTrackingState(
      trip: trip ?? this.trip,
      driver: driver ?? this.driver,
      loadingInitial: loadingInitial ?? this.loadingInitial,
      searchTimedOut: searchTimedOut ?? this.searchTimedOut,
      actionInFlight: actionInFlight ?? this.actionInFlight,
      error: clearError ? null : (error ?? this.error),
      rated: rated ?? this.rated,
    );
  }

  @override
  List<Object?> get props => [
    trip?.id,
    trip?.status,
    trip?.driverId,
    trip?.fare,
    trip?.pin,
    driver?.id,
    loadingInitial,
    searchTimedOut,
    actionInFlight,
    error,
    rated,
  ];
}
