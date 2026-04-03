import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    loadProfile();
  }

  void loadProfile() {
    emit(
      const ProfileLoaded(
        name: 'Alex Volt',
        email: 'alex.volt@example.com',
        phone: '+1 234 567 8900',
      ),
    );
  }

  void updateProfile(String name, String email, String phone) {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      emit(
        ProfileLoaded(
          name: name,
          email: email,
          phone: phone,
          profileImagePath: current.profileImagePath,
        ),
      );
    } else {
      emit(ProfileLoaded(name: name, email: email, phone: phone));
    }
  }

  void updateProfilePicture(String path) {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      emit(
        ProfileLoaded(
          name: current.name,
          email: current.email,
          phone: current.phone,
          profileImagePath: path,
        ),
      );
    }
  }
}
