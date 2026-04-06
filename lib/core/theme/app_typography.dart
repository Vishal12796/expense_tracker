import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._(); // private constructor

  static const String fontFamily = 'Lato';

  static const TextTheme textTheme = TextTheme(
    // 🔹 Body
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    // 🔹 Titles
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),

    // 🔹 Headlines
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 34,
      fontWeight: FontWeight.w700,
    ),

    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );
}
