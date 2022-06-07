import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kTextDark = Colors.black;
Color kTextLight = Colors.white;

class Styles {
  static const edgeInsetAll16 = EdgeInsets.all(16);
  static const edgeInsetAll10 = EdgeInsets.all(10);
  static const edgeInsetAll7 = EdgeInsets.all(7);
  static const edgeInsetAll5 = EdgeInsets.all(5);
  static const edgeInsetAll3 = EdgeInsets.all(3);
  static const edgeInsetAll0 = EdgeInsets.zero;
  static const edgeInsetHorizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const edgeInsetVertical5 = EdgeInsets.symmetric(vertical: 5);
  static const edgeInsetHorizontal5 = EdgeInsets.symmetric(horizontal: 5);
  static const edgeInsetVertical16 = EdgeInsets.symmetric(vertical: 16);
  static const edgeInsetVertical10 = EdgeInsets.symmetric(vertical: 10);
  static const edgeInsetHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const edgeInsetSymmetric10 = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
  static const edgeInsetSymmetric8 = EdgeInsets.symmetric(horizontal: 8, vertical: 8);
  static const edgeInsetSymmetric5 = EdgeInsets.symmetric(horizontal: 5, vertical: 5);

  static const double smallButtonSplashRadius = 18;

  static const double materialEventCardHeight = 200;

  static const double cardThreeElevation = 3;
  static const double cardTenElevation = 10;

  static const circularBorderRadius5 = BorderRadius.all(Radius.circular(5));
  static const circularBorderRadius7 = BorderRadius.all(Radius.circular(7));
  static const mainCardBorderRadius = BorderRadius.all(Radius.circular(10));

  static const circleTapBorderRadius = BorderRadius.all(Radius.circular(20));

  static const RoundedRectangleBorder mainCardShape = RoundedRectangleBorder(borderRadius: mainCardBorderRadius);
}

class PortfolioAppTheme {
  static Typography textTypography = Typography.material2021(black: Typography().black, white: Typography().white);

  static TextTheme textTheme = ThemeData.light().textTheme;

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.epilogue(textStyle: textTheme.displayLarge),
    displayMedium: GoogleFonts.epilogue(textStyle: textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w800)),
    displaySmall: GoogleFonts.epilogue(textStyle: textTheme.displaySmall),
    headlineLarge: GoogleFonts.epilogue(textStyle: textTheme.headlineLarge),
    headlineMedium: GoogleFonts.epilogue(textStyle: textTheme.headlineMedium),
    headlineSmall: GoogleFonts.epilogue(textStyle: textTheme.headlineSmall),
    titleLarge: GoogleFonts.epilogue(textStyle: textTheme.titleLarge),
    titleMedium: GoogleFonts.epilogue(textStyle: textTheme.titleMedium),
    titleSmall: GoogleFonts.epilogue(textStyle: textTheme.titleSmall),
    bodyLarge: GoogleFonts.epilogue(textStyle: textTheme.bodyLarge),
    bodyMedium: GoogleFonts.epilogue(textStyle: textTheme.bodyMedium),
    bodySmall: GoogleFonts.epilogue(textStyle: textTheme.bodySmall),
    labelLarge: GoogleFonts.epilogue(textStyle: textTheme.labelLarge),
    labelMedium: GoogleFonts.epilogue(textStyle: textTheme.labelMedium),
    labelSmall: GoogleFonts.epilogue(textStyle: textTheme.labelSmall),
  );

  static ThemeData light() {
    return ThemeData(
      dividerColor: const Color(0xFFF9F9F9),
      bottomAppBarColor: const Color(0xFFF1F1F1),
      canvasColor: Colors.grey[50],
      cardColor: Colors.white,
      shadowColor: const Color(0xFFC3EDDA),
      indicatorColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFF1B232E),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      typography: textTypography,
      textTheme: darkTextTheme,
      primaryColor: const Color(0xFFEF6D58),
      colorScheme: const ColorScheme.light(primary: Color(0xFFEF6D58)).copyWith(secondary: Colors.deepOrangeAccent),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      dividerColor: Colors.black,
      bottomAppBarColor: const Color(0xFF272C2F),
      canvasColor: Colors.black54,
      cardColor: Colors.grey.shade900,
      shadowColor: const Color(0xFF192C31),
      indicatorColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1B232E),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      typography: textTypography,
      textTheme: darkTextTheme,
      primaryColor: const Color(0xFFEF6D58),
      colorScheme: const ColorScheme.dark(primary: Color(0xFFEF6D58)).copyWith(secondary: Colors.deepOrangeAccent),
    );
  }
}