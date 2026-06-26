import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/driver_earnings_repo.dart';
import 'driver_earnings_state.dart';

class DriverEarningsCubit extends Cubit<DriverEarningsState> {
  final DriverEarningsRepo _repo;

  DriverEarningsCubit(this._repo) : super(DriverEarningsInitial());

  Future<void> loadEarnings() async {
    emit(DriverEarningsLoading());
    try {
      final earnings = await _repo.getEarnings();
      emit(DriverEarningsLoaded(earnings: earnings));
    } catch (e) {
      emit(
        const DriverEarningsError('Failed to load earnings. Please try again.'),
      );
    }
  }
}
