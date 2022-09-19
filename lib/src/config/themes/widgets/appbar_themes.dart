import 'package:bookingapp/src/config/themes/system/system_overlay_style.dart';
import 'package:flutter/material.dart';

class AppBarThemes {
  static AppBarTheme appBarTheme({required bool isLight}) {
    return AppBarTheme(
      systemOverlayStyle: AppSystemUiOverlayStyle.setSystemUiOverlayStyle(isLight: isLight),
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(color: isLight ? Colors.black : Colors.white),
      elevation: 0,
    );
  }
}
