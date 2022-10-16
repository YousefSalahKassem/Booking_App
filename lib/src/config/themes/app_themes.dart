import 'package:bookingapp/app.dart';
import 'package:bookingapp/src/config/themes/widgets/appbar_themes.dart';
import 'package:bookingapp/src/config/themes/widgets/elevated_button_themes.dart';
import 'package:bookingapp/src/config/themes/widgets/textfield_themes.dart';
import 'package:bookingapp/src/core/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color primaryColor(bool isLight) {
    ColorType colorTypeData = applicationContext == null ? ColorType.Verdigris : ColorType.Malibu;

    return getColor(colorTypeData, isLight);
  }

  static Color scaffoldBackgroundColor(bool isLight) =>
      isLight ? const Color(0xFFF7F7F7) : const Color(0xFF1A1A1A);

  static Color redErrorColor(bool isLight) =>
      isLight ? const Color(0xFFAC0000) : const Color(0xFFAC0000);

  static Color backgroundColor(bool isLight) =>
      isLight ? const Color(0xFFFFFFFF) : const Color(0xFF2C2C2C);

  static Color primaryTextColor(bool isLight) =>
      isLight ? const Color(0xFF262626) : const Color(0xFFFFFFFF);

  static Color secondaryTextColor(bool isLight) =>
      isLight ? const Color(0xFFADADAD) : const Color(0xFF6D6D6D);

  static Color get whiteColor => const Color(0xFFFFFFFF);

  static Color get backColor => const Color(0xFF262626);

  static Color fontcolor(bool isLight) =>
      isLight ? const Color(0xFF1A1A1A) : const Color(0xFFF7F7F7);

  static ThemeData getThemeData(bool isLight) =>
      isLight ? _buildLightTheme(isLight) : _buildDarkTheme(isLight);

  static TextTheme _buildTextTheme(TextTheme base) {
    FontFamilyType fontType =
        applicationContext == null ? FontFamilyType.WorkSans : FontFamilyType.Satisfy;
    return base.copyWith(
      headline1: getTextStyle(fontType, base.headline1!),
      //f-size 96
      headline2: getTextStyle(fontType, base.headline2!),
      //f-size 60
      headline3: getTextStyle(fontType, base.headline3!),
      //f-size 48
      headline4: getTextStyle(fontType, base.headline4!),
      //f-size 34
      headline5: getTextStyle(fontType, base.headline5!),
      //f-size 24
      headline6: getTextStyle(
        fontType,
        base.headline6!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      //f-size 20
      button: getTextStyle(fontType, base.button!),
      //f-size 14
      caption: getTextStyle(fontType, base.caption!),
      //f-size 12
      bodyText1: getTextStyle(fontType, base.bodyText1!),
      //f-size 16
      bodyText2: getTextStyle(fontType, base.bodyText2!),
      //f-size 14
      subtitle1: getTextStyle(
        fontType,
        base.subtitle1!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      //f-size 16
      subtitle2: getTextStyle(fontType, base.subtitle2!),
      //f-size 14
      overline: getTextStyle(fontType, base.overline!), //f-size 10
    );
  }

// we also get some Light and Dark color variants
  static Color getColor(ColorType colordata, bool isLight) {
    switch (colordata) {
      case ColorType.Verdigris:
        return isLight ? const Color(0xFF4FBE9F) : const Color(0xFF4FBE9F);
      case ColorType.Malibu:
        return isLight ? const Color(0xFF5DCAEC) : const Color(0xFF5DCAEC);
      case ColorType.DarkSkyBlue:
        return isLight ? const Color(0xFF458CEA) : const Color(0xFF458CEA);
      case ColorType.BilobaFlower:
        return isLight ? const Color(0xFFff5f5f) : const Color(0xFFff5f5f);
    }
  }

  static TextStyle getTextStyle(FontFamilyType fontFamilyType, TextStyle textStyle) {
    switch (fontFamilyType) {
      case FontFamilyType.Montserrat:
        return GoogleFonts.montserrat(textStyle: textStyle);
      case FontFamilyType.WorkSans:
        return GoogleFonts.workSans(textStyle: textStyle);
      case FontFamilyType.Varela:
        return GoogleFonts.varela(textStyle: textStyle);
      case FontFamilyType.Satisfy:
        return GoogleFonts.satisfy(textStyle: textStyle);
      case FontFamilyType.DancingScript:
        return GoogleFonts.dancingScript(textStyle: textStyle);
      case FontFamilyType.KaushanScript:
        return GoogleFonts.kaushanScript(textStyle: textStyle);
      default:
        return GoogleFonts.roboto(textStyle: textStyle);
    }
  }

  static ThemeData _buildLightTheme(bool isLight) {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor(isLight),
      secondary: primaryColor(isLight),
    );
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      brightness: isLight ? Brightness.light : Brightness.dark,
      appBarTheme: AppBarThemes.appBarTheme(isLight: isLight),
      elevatedButtonTheme: AppButtonThemes.elevatedButtonTheme(),
      inputDecorationTheme: AppTextFieldThemes.inputDecorationTheme(isLight: isLight),
      useMaterial3: true,
      backgroundColor: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF2C2C2C),
      scaffoldBackgroundColor: isLight ? const Color(0xFFF7F7F7) : const Color(0xFF1A1A1A),
      canvasColor: scaffoldBackgroundColor(isLight),
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(isLight),
      cardTheme: _cardTheme(isLight),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData _buildDarkTheme(isLight) {
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor(isLight),
      secondary: primaryColor(isLight),
    );
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      brightness: isLight ? Brightness.light : Brightness.dark,
      appBarTheme: AppBarThemes.appBarTheme(isLight: isLight),
      elevatedButtonTheme: AppButtonThemes.elevatedButtonTheme(),
      inputDecorationTheme: AppTextFieldThemes.inputDecorationTheme(isLight: isLight),
      useMaterial3: true,
      backgroundColor: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF2C2C2C),
      scaffoldBackgroundColor: isLight ? const Color(0xFFF7F7F7) : const Color(0xFF1A1A1A),
      canvasColor: scaffoldBackgroundColor(isLight),
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(isLight),
      cardTheme: _cardTheme(isLight),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static DialogTheme _dialogTheme(bool isLight) {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: backgroundColor(isLight),
    );
  }

  static CardTheme _cardTheme(bool isLight) {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor(isLight),
      shadowColor: secondaryTextColor(isLight).withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(0),
    );
  }

  static mapCardDecoration(bool isLight) => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor(isLight),
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Theme.of(applicationContext!).dividerColor,
              offset: const Offset(4, 4),
              blurRadius: 8.0),
        ],
      );

  static buttonDecoration(bool isLight) => BoxDecoration(
        color: AppTheme.primaryColor(isLight),
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationContext!).dividerColor,
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      );

  static searchBarDecoration(bool isLight) => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor(isLight),
        borderRadius: const BorderRadius.all(Radius.circular(38)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationContext!).dividerColor,
            blurRadius: 8,
            // offset: Offset(4, 4),
          ),
        ],
      );

  static boxDecoration(bool isLight) => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor(isLight),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationContext!).dividerColor,
            //   offset: Offset(2, 2),
            blurRadius: 8,
          ),
        ],
      );
}

enum ThemeModeType {
  system,
  dark,
  light,
}
