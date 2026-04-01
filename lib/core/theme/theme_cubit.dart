import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_colors.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    AppColors.setLight();
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      AppColors.setDark();
      emit(ThemeMode.dark);
    } else {
      AppColors.setLight();
      emit(ThemeMode.light);
    }
  }
}
