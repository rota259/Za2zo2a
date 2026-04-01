import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/trips_repo.dart';
import 'trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripsRepo _repo;

  TripsCubit(this._repo) : super(TripsInitial());

  Future<void> loadTrips() async {
    emit(TripsLoading());
    try {
      final trips = await _repo.getTripHistory();
      emit(TripsLoaded(trips));
    } catch (e) {
      emit(const TripsError('Failed to load trips.'));
    }
  }
}
