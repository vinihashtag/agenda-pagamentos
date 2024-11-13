import 'package:flutter/material.dart';

final class AppColors {
  AppColors._();
  // * Colors default app
  static const Color primary = Colors.blue;
  static const Color secondary = Color.fromARGB(255, 11, 62, 138);

  static const Color statusBar = Color.fromARGB(255, 0, 0, 0);
  static const Color disabled = Color.fromARGB(255, 171, 171, 171);
  static const Color hint = Color.fromARGB(255, 210, 208, 208);

  // * Custom colors
  static const Color error = Color(0xffF44336);
  static const Color success = Color(0xff4CAF50);
  static const Color warning = Color(0xffFF9800);
  static const Color info = Color(0xff2196F3);
  static const Color greyDark = Color(0xff4F4F4F);
}
