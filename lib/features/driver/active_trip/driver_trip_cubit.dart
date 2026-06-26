import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/network/api_error.dart';
import '../../../core/services/location_service.dart';
import '../../trip/data/models/trip_models.dart';
import '../../trip/data/repos/maps_repo.dart';
import '../../trip/data/repos/trip_repo.dart';
import '../data/driver_repo.dart';
import 'driver_trip_state.dart';

/// Driver's view of an accepted trip:
///   accepted → (Arrived → enter PIN → start) → in_progress → (complete)
///
/// Polls the trip to detect a rider cancellation, and periodically pushes the
/// driver's GPS. Timers pause while backgrounded and are cancelled on close.
class DriverTripCubit extends Cubit<DriverTripState> {
  final TripRepo _tripRepo;
  final DriverRepo _driverRepo;
  final MapsRepo _mapsRepo;
  final String tripId;

  static const Duration pollInterval = Duration(seconds: 5);
  static const Duration locationInterval = Duration(seconds: 10);

  Timer? _pollTimer;
  Timer? _locationTimer;
  bool _fetching = false;
  bool _routeLoaded = false;

  DriverTripCubit(
    this._tripRepo,
    this._driverRepo,
    this._mapsRepo,
    this.tripId,
  ) : super(const DriverTripState());

  Future<void> start() async {
    await _refreshLocation();
    await _poll();
    resume();
  }

  void resume() {
    _pollTimer?.cancel();
    _locationTimer?.cancel();
    _pollTimer = Timer.periodic(pollInterval, (_) => _poll());
    _locationTimer =
        Timer.periodic(locationInterval, (_) => _refreshLocation());
  }

  void pause() {
    _pollTimer?.cancel();
    _locationTimer?.cancel();
    _pollTimer = null;
    _locationTimer = null;
  }

  Future<void> _poll() async {
    if (_fetching || isClosed) return;
    _fetching = true;
    try {
      final trip = await _tripRepo.getTrip(tripId);
      if (isClosed) return;
      emit(state.copyWith(trip: trip, loading: false, clearError: true));
      if (trip.status == TripStatus.completed ||
          trip.status == TripStatus.cancelled) {
        pause();
      }
      _maybeLoadHeadingRoute(trip);
    } on ApiError catch (e) {
      if (!isClosed) emit(state.copyWith(loading: false, error: e.message));
    } finally {
      _fetching = false;
    }
  }

  Future<void> _refreshLocation() async {
    try {
      final Position pos = await LocationService.getCurrentLocation();
      final here = LatLng(pos.latitude, pos.longitude);
      if (!isClosed) emit(state.copyWith(driverLocation: here));
      try {
        await _driverRepo.updateLocation(here);
      } on ApiError {
        // best-effort
      }
      _maybeLoadHeadingRoute(state.trip);
    } catch (_) {
      // location unavailable
    }
  }

  /// Draw driver → pickup route once, while heading to pickup.
  Future<void> _maybeLoadHeadingRoute(TripModel? trip) async {
    if (_routeLoaded || trip == null) return;
    final pickup = trip.origin?.latLng;
    final here = state.driverLocation;
    if (pickup == null || here == null) return;
    if (trip.status != TripStatus.accepted) return;
    _routeLoaded = true;
    try {
      final route = await _mapsRepo.route(origin: here, destination: pickup);
      if (!isClosed) emit(state.copyWith(headingRoute: route.points));
    } on ApiError {
      _routeLoaded = false; // allow a later retry
    }
  }

  void markArrived() => emit(state.copyWith(arrived: true));

  /// Start trip without manual PIN entry — uses the trip's own PIN from the
  /// server. PIN verification is disabled during testing.
  Future<void> startTripNoPIN() async {
    if (state.actionInFlight) return;
    emit(state.copyWith(actionInFlight: true, clearPinError: true));
    try {
      final trip = await _tripRepo.getTrip(tripId);
      if (trip.status == TripStatus.cancelled) {
        emit(state.copyWith(trip: trip, actionInFlight: false));
        return;
      }
      final pin = trip.pin ?? '';
      final updated = await _driverRepo.startTrip(tripId, pin: pin);
      if (!isClosed) emit(state.copyWith(trip: updated, actionInFlight: false));
    } on ApiError catch (e) {
      if (!isClosed) {
        emit(state.copyWith(actionInFlight: false, error: e.message));
      }
    }
  }

  Future<void> startTrip(String pin) async {
    if (state.actionInFlight) return;
    emit(state.copyWith(actionInFlight: true, clearPinError: true));
    try {
      final trip = await _tripRepo.getTrip(tripId); // ensure not cancelled
      if (trip.status == TripStatus.cancelled) {
        emit(state.copyWith(trip: trip, actionInFlight: false));
        return;
      }
      final updated = await _driverRepo.startTrip(tripId, pin: pin);
      if (!isClosed) emit(state.copyWith(trip: updated, actionInFlight: false));
    } on ApiError catch (e) {
      if (!isClosed) {
        // Wrong PIN comes back as a 4xx — keep field, show inline error.
        emit(state.copyWith(
          actionInFlight: false,
          pinError: e.isConflict ? 'Incorrect PIN. Please try again.' : e.message,
        ));
      }
    }
  }

  Future<void> complete() async {
    if (state.actionInFlight) return;
    emit(state.copyWith(actionInFlight: true, clearError: true));
    try {
      final updated = await _driverRepo.completeTrip(tripId);
      pause();
      if (!isClosed) emit(state.copyWith(trip: updated, actionInFlight: false));
    } on ApiError catch (e) {
      if (!isClosed) {
        emit(state.copyWith(actionInFlight: false, error: e.message));
      }
    }
  }

  @override
  Future<void> close() {
    pause();
    return super.close();
  }
}
