import 'package:bookingapp/src/config/themes/widgets/appbar_themes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData appTheme({required bool isLight}) {
    return ThemeData(
      brightness: isLight ? Brightness.light : Brightness.dark,
      appBarTheme: AppBarThemes.appBarTheme(isLight: isLight),
      scaffoldBackgroundColor: isLight ? Colors.white : Colors.black,
    );
  }
}
