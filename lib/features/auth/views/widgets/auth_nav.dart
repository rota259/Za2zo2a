import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/auth_model.dart';

/// Route an authenticated user to the correct home by role.
/// Unknown role falls back to the rider home (and is flagged at runtime).
void routeByRole(BuildContext context, UserModel user) {
  if (user.isDriver) {
    context.go('/driver/home');
  } else {
    context.go('/home');
  }
}

void showAuthError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
}
