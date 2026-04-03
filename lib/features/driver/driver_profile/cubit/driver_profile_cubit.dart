import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/driver_profile_repo.dart';
import 'driver_profile_state.dart';

class DriverProfileCubit extends Cubit<DriverProfileState> {
  final DriverProfileRepo _repo;

  DriverProfileCubit(this._repo) : super(DriverProfileInitial());

  Future<void> loadProfile() async {
    emit(DriverProfileLoading());
    try {
      final profile = await _repo.getProfile();
      emit(DriverProfileLoaded(profile));
    } catch (e) {
      emit(const DriverProfileError('Failed to load profile. Please try again.'));
    }
  }

  Future<void> toggleOnlineStatus() async {
    if (state is DriverProfileLoaded) {
      final current = (state as DriverProfileLoaded).profile;
      final newStatus = !current.isOnline;
      // Optimistic update
      emit(DriverProfileLoaded(current.copyWith(isOnline: newStatus)));
      try {
        await _repo.toggleOnlineStatus(newStatus);
      } catch (e) {
        // Revert on failure
        emit(DriverProfileLoaded(current));
        emit(const DriverProfileError('Failed to update status.'));
      }
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    if (state is DriverProfileLoaded) {
      final current = (state as DriverProfileLoaded).profile;
      emit(DriverProfileUpdating(current));
      try {
        await _repo.updateProfile(data);
        await loadProfile();
      } catch (e) {
        emit(DriverProfileLoaded(current));
        emit(const DriverProfileError('Failed to update profile.'));
      }
    }
  }
}
