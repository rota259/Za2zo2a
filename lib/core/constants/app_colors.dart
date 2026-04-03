import 'package:flutter/material.dart';

class AppColors {
  // Primary & Secondary
  static Color primary = Color(0xFFE23030); // Crimson Red
  static Color secondary = Color(0xFF2C2C2C); // Dark Grey
  static Color background = Color(0xFFFFFFFF);

  // Text Colors
  static Color textPrimary = Color(0xFF1E1E1E);
  static Color textSecondary = Color(0xFF757575);
  static Color textInverse = Color(0xFFFFFFFF);

  // Semantic
  static Color success = Color(0xFF4CAF50);
  static Color error = Color(0xFFD32F2F);
  static Color warning = Color(0xFFFBC02D);
  static Color info = Color(0xFF1976D2);

  // Grey shades
  static Color grey50 = Color(0xFFFAFAFA);
  static Color grey100 = Color(0xFFF5F5F5);
  static Color grey200 = Color(0xFFEEEEEE);
  static Color grey300 = Color(0xFFE0E0E0);
  static Color grey400 = Color(0xFFBDBDBD);
  static Color grey500 = Color(0xFF9E9E9E);
  static Color grey600 = Color(0xFF757575);
  static Color grey900 = Color(0xFF212121);

  // Map overlays
  static Color mapRouteLine = Color(0xFFE23030);

  // Icon backgrounds (tinted)
  static const Color pinkTint = Color(0xFFFDE8E8);
  static const Color orangeTint = Color(0xFFFEF3E7);
  static const Color greyTint = Color(0xFFF3F4F6);
  static const Color blueTint = Color(0xFFEBF5FF);

  static void setDark() {
    primary = const Color(0xFFE23030);
    secondary = const Color(0xFFF3F4F6);
    background = const Color(0xFF121212);
    textPrimary = const Color(0xFFFFFFFF);
    textSecondary = const Color(0xFFAAAAAA);
    grey50 = const Color(0xFF1E1E1E);
    grey100 = const Color(0xFF2C2C2C);
    grey200 = const Color(0xFF333333);
    grey300 = const Color(0xFF444444);
    grey400 = const Color(0xFF666666);
    grey500 = const Color(0xFFAAAAAA);
    success = const Color(0xFF10B981);
    error = const Color(0xFFEF4444);
    warning = const Color(0xFFF59E0B);
    info = const Color(0xFF3B82F6);
  }

  static void setLight() {
    primary = const Color(0xFFE23030);
    secondary = const Color(0xFF2C2C2C);
    background = const Color(0xFFFFFFFF);
    textPrimary = const Color(0xFF1E1E1E);
    textSecondary = const Color(0xFF757575);
    grey50 = const Color(0xFFF9FAFB);
    grey100 = const Color(0xFFF3F4F6);
    grey200 = const Color(0xFFE5E7EB);
    grey300 = const Color(0xFFD1D5DB);
    grey400 = const Color(0xFF9CA3AF);
    grey500 = const Color(0xFF6B7280);
    success = const Color(0xFF10B981);
    error = const Color(0xFFEF4444);
    warning = const Color(0xFFF59E0B);
    info = const Color(0xFF3B82F6);
  }
}
