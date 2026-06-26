import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_error.dart';
import '../../../driver/data/driver_repo.dart';
import '../../data/models/trip_models.dart';
import '../../data/repos/trip_repo.dart';
import 'trip_tracking_state.dart';

/// Rider-side live tracking. Polls GET /api/trips/:id every [pollInterval] and
/// reflects each status change. Loads the assigned driver profile on accept.
///
/// Polling pauses when the app is backgrounded ([pause]) and resumes on
/// foreground ([resume]); the timer is always cancelled in [close].
class TripTrackingCubit extends Cubit<TripTrackingState> {
  final TripRepo _tripRepo;
  final DriverRepo _driverRepo;
  final String tripId;

  static const Duration pollInterval = Duration(seconds: 4);

  /// After this long still in `requested`, surface "no drivers found".
  static const Duration noDriverTimeout = Duration(minutes: 2);

  Timer? _timer;
  DateTime? _searchStartedAt;
  bool _fetching = false;

  TripTrackingCubit(this._tripRepo, this._driverRepo, this.tripId)
    : super(const TripTrackingState());

  Future<void> start() async {
    _searchStartedAt ??= DateTime.now();
    await _poll();
    resume();
  }

  void resume() {
    _timer?.cancel();
    _timer = Timer.periodic(pollInterval, (_) => _poll());
  }

  void pause() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _poll() async {
    if (_fetching || isClosed) return;
    _fetching = true;
    try {
      final trip = await _tripRepo.getTrip(tripId);
      if (isClosed) return;

      // No-driver timeout while still searching.
      final timedOut = trip.status == TripStatus.requested &&
          _searchStartedAt != null &&
          DateTime.now().difference(_searchStartedAt!) > noDriverTimeout;

      emit(state.copyWith(
        trip: trip,
        loadingInitial: false,
        searchTimedOut: timedOut,
        clearError: true,
      ));

      // Load driver profile once assigned.
      if (trip.driverId != null &&
          trip.driverId!.isNotEmpty &&
          state.driver == null) {
        _loadDriver(trip.driverId!);
      }

      // Stop polling on terminal states.
      if (trip.status == TripStatus.completed ||
          trip.status == TripStatus.cancelled) {
        pause();
      }
    } on ApiError catch (e) {
      if (!isClosed) {
        emit(state.copyWith(loadingInitial: false, error: e.message));
      }
    } finally {
      _fetching = false;
    }
  }

  Future<void> _loadDriver(String driverId) async {
    try {
      final driver = await _driverRepo.driverById(driverId);
      if (!isClosed) emit(state.copyWith(driver: driver));
    } on ApiError {
      // Non-fatal — the trip card still shows what we have.
    }
  }

  /// Manual refresh / retry after a timeout.
  Future<void> retry() async {
    _searchStartedAt = DateTime.now();
    emit(state.copyWith(searchTimedOut: false, clearError: true));
    await _poll();
  }

  Future<void> cancel({required String reason}) async {
    if (state.actionInFlight) return;
    emit(state.copyWith(actionInFlight: true, clearError: true));
    try {
      await _tripRepo.cancelTrip(tripId, reason: reason);
      pause();
      await _poll(); // refresh to the cancelled snapshot
      if (!isClosed) emit(state.copyWith(actionInFlight: false));
    } on ApiError catch (e) {
      if (!isClosed) {
        emit(state.copyWith(actionInFlight: false, error: e.message));
      }
    }
  }

  Future<void> rate({required int rating, String? comment}) async {
    if (state.actionInFlight) return;
    emit(state.copyWith(actionInFlight: true, clearError: true));
    try {
      await _tripRepo.rateTrip(tripId, rating: rating, comment: comment);
      if (!isClosed) emit(state.copyWith(actionInFlight: false, rated: true));
    } on ApiError catch (e) {
      if (!isClosed) {
        emit(state.copyWith(actionInFlight: false, error: e.message));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
