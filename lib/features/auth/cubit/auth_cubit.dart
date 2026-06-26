import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_error.dart';
import '../../../core/services/session_manager.dart';
import '../data/models/auth_model.dart';
import '../data/repos/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _repo;
  final SessionManager _session;

  AuthCubit(this._repo, this._session) : super(const AuthInitial());

  bool get isBusy => state is AuthLoading;

  /// Boot-time session restore: if a token is stored, verify it via GET /me.
  Future<void> tryRestoreSession() async {
    if (!_session.isLoggedIn) {
      emit(const Unauthenticated());
      return;
    }
    emit(const AuthLoading());
    try {
      final user = await _repo.me();
      emit(Authenticated(user));
    } catch (_) {
      // Any failure here (expired token, network) → treat as logged-out.
      // Never leave the app stuck in AuthLoading on boot.
      await _session.clear();
      emit(const Unauthenticated());
    }
  }

  Future<void> login({required String phone, required String password}) async {
    if (isBusy) return; // guard against double-submit
    emit(const AuthLoading());
    try {
      final session = await _repo.login(phone: phone, password: password);
      emit(Authenticated(session.user));
    } on ApiError catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      // Safety net: any unexpected error must still clear the loading state.
      emit(AuthFailure('Something went wrong. Please try again. ($e)'));
    }
  }

  Future<void> registerRider({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    if (isBusy) return;
    emit(const AuthLoading());
    try {
      final session = await _repo.registerRider(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
      emit(Authenticated(session.user));
    } on ApiError catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Something went wrong. Please try again. ($e)'));
    }
  }

  Future<void> registerDriver({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String licenseNumber,
    required VehicleInfo vehicleInfo,
  }) async {
    if (isBusy) return;
    emit(const AuthLoading());
    try {
      final session = await _repo.registerDriver(
        name: name,
        phone: phone,
        email: email,
        password: password,
        licenseNumber: licenseNumber,
        vehicleInfo: vehicleInfo,
      );
      emit(Authenticated(session.user));
    } on ApiError catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Something went wrong. Please try again. ($e)'));
    }
  }

  Future<void> deleteAccount({required String password}) async {
    if (isBusy) return;
    emit(const AuthLoading());
    try {
      await _repo.deleteAccount(password: password);
      emit(const Unauthenticated());
    } on ApiError catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Something went wrong. Please try again. ($e)'));
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    emit(const Unauthenticated());
  }
}
