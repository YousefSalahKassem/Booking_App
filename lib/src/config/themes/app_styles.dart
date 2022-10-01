import 'package:bookingapp/src/config/themes/system/system_overlay_style.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/core/utils/media_query_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppStyles {
  static void _setSystemOverlayDark() {
    return SystemChrome.setSystemUIOverlayStyle(AppSystemUiOverlayStyle.dark);
  }

  static void _setSystemOverlayLight() {
    return SystemChrome.setSystemUIOverlayStyle(AppSystemUiOverlayStyle.light);
  }

  static bool isLightMode(BuildContext context) {
    return context.brightness == Brightness.light;
  }

  static bool isDarkMode(BuildContext context) {
    return context.brightness == Brightness.dark;
  }

  static void setSystemOverlay(BuildContext context) {
    AppStyles.isLightMode(context)
        ? AppStyles._setSystemOverlayLight()
        : AppStyles._setSystemOverlayDark();
  }

  static hintTextStyle() {
    return const TextStyle(color: AppColors.hintColorLight);
  }

  static clickableTextStyle() {
    return const TextStyle(color: AppColors.buttonGreen, fontSize: 15);
  }
}
