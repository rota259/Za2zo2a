import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.login(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError('Failed to login. Please try again.'));
    }
  }

  Future<void> signup(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.signup(name, email, phone, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError('Failed to sign up. Please try again.'));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(AuthLoading());
    try {
      // Mock OTP verification
      await Future.delayed(const Duration(seconds: 1));
      if (otp == '1234') {
        emit(const AuthError('Invalid OTP'));
        return;
      }
      // Re-emit success to trigger navigation
      emit(AuthSuccess(await _authRepo.login('test@test.com', 'password')));
    } catch (e) {
      emit(AuthError('Failed to verify OTP.'));
    }
  }
}
