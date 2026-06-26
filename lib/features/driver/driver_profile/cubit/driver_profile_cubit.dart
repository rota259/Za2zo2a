import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_error.dart';
import '../data/models/verification_model.dart';
import '../data/repos/profile_repository.dart';
import 'driver_profile_state.dart';

class DriverProfileCubit extends Cubit<DriverProfileState> {
  final ProfileRepository _repo;

  DriverProfileCubit(this._repo) : super(DriverProfileInitial());

  Future<void> loadProfile() async {
    emit(DriverProfileLoading());
    try {
      final profile = await _repo.getProfile();
      emit(DriverProfileLoaded(profile));
    } on ApiError catch (e) {
      emit(DriverProfileError(e.message));
    } catch (e) {
      emit(DriverProfileError('Failed to load profile: $e'));
    }
  }

  Future<void> toggleOnlineStatus() async {
    if (state is DriverProfileLoaded) {
      final current = (state as DriverProfileLoaded).profile;
      final newStatus = !current.isOnline;
      emit(DriverProfileLoaded(current.copyWith(isOnline: newStatus)));
      try {
        await _repo.toggleOnlineStatus(newStatus);
      } catch (e) {
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

  Future<void> uploadDocument({
    required VerificationDocumentType type,
    required String filePath,
  }) async {
    if (state is! DriverProfileLoaded) return;

    final current = (state as DriverProfileLoaded).profile;
    emit(DriverProfileUpdating(current));
    try {
      await _repo.uploadDocument(type: type, filePath: filePath);
      await loadProfile();
    } on ApiError catch (_) {
      emit(DriverProfileLoaded(current));
      rethrow;
    } catch (_) {
      emit(DriverProfileLoaded(current));
      rethrow;
    }
  }
}
