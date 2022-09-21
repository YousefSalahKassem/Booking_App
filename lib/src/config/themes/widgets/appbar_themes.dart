import 'package:bookingapp/src/config/themes/system/system_overlay_style.dart';
import 'package:bookingapp/src/config/themes/widgets/iconThemes.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarThemes {
  static AppBarTheme appBarTheme({required bool isLight}) {
    return AppBarTheme(
      systemOverlayStyle: AppSystemUiOverlayStyle.setSystemUiOverlayStyle(isLight: isLight),
      backgroundColor:
          isLight ? AppColors.scaffoldBackgroundLight : AppColors.scaffoldBackgroundDark,
      titleTextStyle: TextStyle(color: isLight ? Colors.black : Colors.white),
      elevation: 0,
      iconTheme: AppIconThemes.iconTheme(isLight: isLight),
      actionsIconTheme: AppIconThemes.iconTheme(isLight: isLight),
    );
  }
}
