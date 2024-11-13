import 'package:flutter/material.dart';

final class AppTypography {
  AppTypography._();

  /// Font Family

  static const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);

  static const TextStyle h1 = TextStyle(
    color: Colors.black,
    fontSize: 98,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  );

  static const TextStyle h2 = TextStyle(
    color: Colors.black,
    fontSize: 61,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  );

  static const TextStyle h3 = TextStyle(
    color: Colors.black,
    fontSize: 49,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle h4 = TextStyle(
    color: Colors.black,
    fontSize: 35,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle h5 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle h6 = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static const TextStyle title = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static const TextStyle subtitle1 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  static const TextStyle subtitle2 = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyText1 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyText2 = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle caption = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static const TextStyle button =
      TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.5);

  static const TextStyle button2 =
      TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.5);

  static const TextStyle overline = TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    // letterSpacing: 1.5,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: h1,
    displayMedium: h2,
    displaySmall: h3,
    headlineLarge: h4,
    headlineMedium: h5,
    headlineSmall: h6,
    titleLarge: title,
    titleMedium: subtitle1,
    titleSmall: subtitle2,
    bodyLarge: bodyText1,
    bodyMedium: bodyText2,
    bodySmall: caption,
    labelLarge: button,
    labelMedium: button2,
    labelSmall: overline,
  );
}
