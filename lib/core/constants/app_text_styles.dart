import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../utils/responsive.dart';

class AppTextStyles {
  // Headings
  static TextStyle h1(BuildContext context) => GoogleFonts.inter(
    fontSize: context.fontPct(28),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle h2(BuildContext context) => GoogleFonts.inter(
    fontSize: context.fontPct(24),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle h3(BuildContext context) => GoogleFonts.inter(
    fontSize: context.fontPct(20),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: context.fontPct(16),
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: context.fontPct(14),
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.inter(
    fontSize: context.fontPct(12),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle caption(BuildContext context) => GoogleFonts.inter(
    fontSize: context.fontPct(10),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Action / Buttons
  static TextStyle button(BuildContext context) => GoogleFonts.inter(
    fontSize: context.fontPct(16),
    fontWeight: FontWeight.w600,
    color: AppColors.textInverse,
  );
}
