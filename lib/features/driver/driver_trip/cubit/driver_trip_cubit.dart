import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/driver_trip_repo.dart';
import '../data/models/driver_trip_model.dart';
import 'driver_trip_state.dart';

class DriverTripCubit extends Cubit<DriverTripState> {
  final DriverTripRepo _repo;

  DriverTripCubit(this._repo) : super(DriverTripInitial());

  /// Called once a ride request is accepted – driver heads to pickup.
  void startHeadingToPickup(DriverTripModel trip) {
    emit(DriverHeadingToPickup(trip: trip));
  }

  /// Called when driver arrives at pickup and confirms rider is on board.
  void startTrip() {
    if (state is DriverHeadingToPickup) {
      final trip = (state as DriverHeadingToPickup).trip;
      emit(DriverTripInProgress(trip: trip));
    }
  }

  /// Called when driver arrives at destination and ends the trip.
  Future<void> completeTrip() async {
    if (state is DriverTripInProgress) {
      final trip = (state as DriverTripInProgress).trip;
      try {
        await _repo.completeTrip(trip.id, trip.fare);
        final completedTrip = DriverTripModel(
          id: trip.id,
          riderName: trip.riderName,
          riderPhoto: trip.riderPhoto,
          riderRating: trip.riderRating,
          pickupAddress: trip.pickupAddress,
          destinationAddress: trip.destinationAddress,
          distanceKm: trip.distanceKm,
          durationMinutes: trip.durationMinutes,
          fare: trip.fare,
          paymentMethod: trip.paymentMethod,
          rideType: trip.rideType,
          status: 'completed',
          createdAt: trip.createdAt,
        );
        emit(DriverTripCompleted(completedTrip));
      } catch (e) {
        emit(
          const DriverTripError(
            'Failed to complete the trip. Please try again.',
          ),
        );
      }
    }
  }

  /// Load driver trip history.
  Future<void> loadTripHistory() async {
    emit(DriverTripLoading());
    try {
      final trips = await _repo.getTripHistory();
      emit(DriverTripHistoryLoaded(trips));
    } catch (e) {
      emit(const DriverTripError('Failed to load trip history.'));
    }
  }

  /// Submit rating for the rider after trip is done.
  Future<void> submitRiderRating(
    String tripId,
    double rating,
    String? comment,
  ) async {
    try {
      await _repo.submitRiderRating(tripId, rating, comment);
    } catch (_) {
      // Non-critical: silent fail
    }
  }

  /// Reset trip state (back to home screen).
  void reset() {
    emit(DriverTripInitial());
  }
}
