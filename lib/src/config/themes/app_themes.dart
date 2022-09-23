import 'package:bookingapp/src/config/themes/widgets/appbar_themes.dart';
import 'package:bookingapp/src/config/themes/widgets/elevated_button_themes.dart';
import 'package:bookingapp/src/config/themes/widgets/textfield_themes.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData appTheme({required bool isLight}) {
    return ThemeData(
      brightness: isLight ? Brightness.light : Brightness.dark,
      appBarTheme: AppBarThemes.appBarTheme(isLight: isLight),
      scaffoldBackgroundColor:
          isLight ? AppColors.scaffoldBackgroundLight : AppColors.scaffoldBackgroundDark,
      fontFamily: AppStrings.fontFamily,
      elevatedButtonTheme: AppButtonThemes.elevatedButtonTheme(),
      inputDecorationTheme: AppTextFieldThemes.inputDecorationTheme(isLight: isLight),
      useMaterial3: true,
    );
  }
}
