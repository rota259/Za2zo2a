import 'package:flutter/material.dart';
import 'package:flutter_tasks_mostafa/core/theme/app_styles.dart';

Widget field(
    String hint,
    IconData icon, {
    TextEditingController? controller,
    bool isPass = false,
    Widget? suffixIcon,
    String? prefixText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: isPass,
        decoration:
            AppStyles.input(
              hint,
              icon,
              suffixIcon:
                  suffixIcon ??
                  (isPass
                      ? Icon(Icons.visibility_off_outlined, color: Colors.grey)
                      : null),
            ).copyWith(
              prefixText: prefixText,
              prefixStyle: TextStyle(color: Colors.grey, fontSize: 16),
            ),
      ),
    );
  }
