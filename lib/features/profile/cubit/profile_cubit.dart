import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void loadFromAuth(AuthCubit authCubit) {
    final authState = authCubit.state;
    if (authState is Authenticated) {
      final u = authState.user;
      emit(ProfileLoaded(
        name: u.name,
        email: u.email,
        phone: u.phone,
      ));
    } else {
      emit(const ProfileLoaded(
        name: 'User',
        email: '',
        phone: '',
      ));
    }
  }

  void loadProfile() {
    // Keep existing interface; data is now loaded via loadFromAuth.
    if (state is ProfileLoaded) return;
    emit(const ProfileLoaded(name: 'User', email: '', phone: ''));
  }

  void updateProfile(String name, String email, String phone) {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      emit(ProfileLoaded(
        name: name,
        email: email,
        phone: phone,
        profileImagePath: current.profileImagePath,
      ));
    } else {
      emit(ProfileLoaded(name: name, email: email, phone: phone));
    }
  }

  void updateProfilePicture(String path) {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      emit(ProfileLoaded(
        name: current.name,
        email: current.email,
        phone: current.phone,
        profileImagePath: path,
      ));
    }
  }
}
