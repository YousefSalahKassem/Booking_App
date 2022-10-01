import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppTextFieldThemes {
  static InputDecorationTheme inputDecorationTheme({required bool isLight}) {
    return InputDecorationTheme(
      isDense: true,
      border:
          OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(30)),
      hintStyle: TextStyle(
        color: isLight ? AppColors.hintColorLight : AppColors.hintColorDark,
        fontFamily: AppStrings.fontFamily,
        fontWeight: FontWeight.normal,
      ),
      filled: true,
      fillColor: isLight ? Colors.white : AppColors.textFieldDark,
    );
  }
}
