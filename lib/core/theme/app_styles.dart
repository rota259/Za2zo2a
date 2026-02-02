import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static const TextStyle title = TextStyle(
    fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.black
  );
  static const TextStyle titleGreen = TextStyle(
    fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary
  );
  static const TextStyle subTitle = TextStyle(fontSize: 14, color: AppColors.grey);
  
  static InputDecoration input(String hint, IconData icon, {Widget? suffixIcon}) => InputDecoration(
    prefixIcon: Icon(icon, color: AppColors.grey),
    suffixIcon: suffixIcon,
    hintText: hint,
    filled: true,
    fillColor: AppColors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
    contentPadding: EdgeInsets.symmetric(vertical: 18),
  );
}