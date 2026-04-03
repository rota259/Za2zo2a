import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/ride_repo.dart';
import '../data/models/ride_model.dart';
import 'ride_state.dart';

class RideCubit extends Cubit<RideState> {
  final RideRepo _rideRepo;

  RideCubit(this._rideRepo) : super(RideInitial());

  Future<void> fetchRideOptions() async {
    emit(RideLoading());
    try {
      final rides = await _rideRepo.getAvailableRides();
      emit(RideOptionsLoaded(rides));
    } catch (e) {
      emit(const RideError('Failed to load ride options.'));
    }
  }

  void requestRide(RideModel ride) {
    // Simulate active trip
    emit(RideActive(ride));
  }

  void endTrip(RideModel ride) {
    // Simulate Trip Summary & Receipt
    emit(RideCompleted(ride));
  }

  void cancelRide() {
    emit(RideInitial());
  }
}
