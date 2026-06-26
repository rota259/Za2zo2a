import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/network/api_error.dart';
import '../../../core/services/location_service.dart';
import '../../trip/data/models/trip_models.dart';
import '../data/driver_repo.dart';
import 'driver_dispatch_state.dart';

/// Driver matching screen logic:
///  - go online → PATCH /availability { isAvailable: true }
///  - while online, poll GET /trips/available and sort nearest-first
///  - accept → POST /:id/accept (race-safe: conflict ⇒ remove + toast)
///  - periodically PATCH /driver/location with GPS
///
/// All timers are paused while backgrounded and cancelled on close.
class DriverDispatchCubit extends Cubit<DriverDispatchState> {
  final DriverRepo _repo;

  static const Duration pollInterval = Duration(seconds: 4);
  static const Duration locationInterval = Duration(seconds: 10);
  static final Distance _distance = const Distance();

  Timer? _pollTimer;
  Timer? _locationTimer;
  bool _fetching = false;

  DriverDispatchCubit(this._repo) : super(const DriverDispatchState());

  Future<void> goOnline() async {
    if (state.toggling) return;
    emit(state.copyWith(toggling: true, clearMessage: true));
    try {
      await _repo.setAvailability(true);
      emit(state.copyWith(isOnline: true, toggling: false, loadingTrips: true));
      await _refreshLocation();
      await _poll();
      _startTimers();
    } on ApiError catch (e) {
      emit(state.copyWith(toggling: false, message: e.message));
    }
  }

  Future<void> goOffline() async {
    if (state.toggling) return;
    emit(state.copyWith(toggling: true, clearMessage: true));
    _stopTimers();
    try {
      await _repo.setAvailability(false);
    } on ApiError catch (e) {
      emit(state.copyWith(message: e.message));
    }
    emit(state.copyWith(isOnline: false, toggling: false, trips: const []));
  }

  void _startTimers() {
    _pollTimer?.cancel();
    _locationTimer?.cancel();
    _pollTimer = Timer.periodic(pollInterval, (_) => _poll());
    _locationTimer =
        Timer.periodic(locationInterval, (_) => _refreshLocation());
  }

  void _stopTimers() {
    _pollTimer?.cancel();
    _locationTimer?.cancel();
    _pollTimer = null;
    _locationTimer = null;
  }

  /// Lifecycle hooks — pause polling while backgrounded.
  void pause() => _stopTimers();
  void resume() {
    if (state.isOnline && _pollTimer == null) _startTimers();
  }

  Future<void> _refreshLocation() async {
    try {
      final Position pos = await LocationService.getCurrentLocation();
      final here = LatLng(pos.latitude, pos.longitude);
      emit(state.copyWith(driverLocation: here));
      // Best-effort push to backend; ignore failures (will retry next tick).
      try {
        await _repo.updateLocation(here);
      } on ApiError {
        // BACKEND TODO: confirm /driver/location accepts {lat,lng}.
      }
    } catch (_) {
      // Location unavailable (permission/services) — keep last known.
    }
  }

  Future<void> _poll() async {
    if (_fetching || isClosed || !state.isOnline) return;
    _fetching = true;
    try {
      final trips = await _repo.availableTrips();
      if (isClosed) return;
      emit(state.copyWith(
        trips: _sortNearest(trips),
        loadingTrips: false,
        clearMessage: true,
      ));
    } on ApiError catch (e) {
      if (!isClosed) {
        emit(state.copyWith(loadingTrips: false, message: e.message));
      }
    } finally {
      _fetching = false;
    }
  }

  /// Client-side nearest-first sort (approximation — see BACKEND TODO about
  /// server-side 2dsphere $near dispatch).
  List<TripModel> _sortNearest(List<TripModel> trips) {
    final here = state.driverLocation;
    if (here == null) return trips;
    final copy = [...trips];
    copy.sort((a, b) {
      final da = a.origin == null
          ? double.maxFinite
          : _distance(here, a.origin!.latLng);
      final db = b.origin == null
          ? double.maxFinite
          : _distance(here, b.origin!.latLng);
      return da.compareTo(db);
    });
    return copy;
  }

  Future<void> accept(String tripId) async {
    if (state.acceptingIds.contains(tripId)) return; // no double-accept
    emit(state.copyWith(
      acceptingIds: {...state.acceptingIds, tripId},
      clearMessage: true,
    ));
    try {
      final trip = await _repo.acceptTrip(tripId);
      _stopTimers();
      emit(state.copyWith(
        acceptedTrip: trip,
        acceptingIds: state.acceptingIds.difference({tripId}),
      ));
    } on ApiError catch (e) {
      final remaining = state.acceptingIds.difference({tripId});
      if (e.isConflict) {
        // Someone else won — remove it and tell the driver.
        emit(state.copyWith(
          trips: state.trips.where((t) => t.id != tripId).toList(),
          acceptingIds: remaining,
          message: 'Trip already taken',
        ));
      } else {
        emit(state.copyWith(acceptingIds: remaining, message: e.message));
      }
    }
  }

  void consumeAccepted() => emit(state.copyWith(clearAccepted: true));

  void dismiss(String tripId) {
    emit(state.copyWith(
      trips: state.trips.where((t) => t.id != tripId).toList(),
    ));
  }

  @override
  Future<void> close() {
    _stopTimers();
    return super.close();
  }
}
