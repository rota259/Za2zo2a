import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.heightPct(56), // 56 corresponds to AppDimensions.buttonHeightMobile
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined 
              ? Colors.transparent 
              : (backgroundColor ?? AppColors.primary),
          elevation: isOutlined ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.widthPct(12)),
            side: isOutlined 
                ? BorderSide(color: backgroundColor ?? AppColors.primary) 
                : BorderSide.none,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: context.widthPct(20),
                width: context.widthPct(20),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: AppTextStyles.button(context).copyWith(
                  color: isOutlined 
                      ? (textColor ?? AppColors.primary) 
                      : (textColor ?? AppColors.textInverse),
                ),
              ),
      ),
    );
  }
}
