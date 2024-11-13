import 'package:flutter/material.dart';

final class AppSizes {
  AppSizes._();

  static const double px4 = 4;
  static const double px8 = 8;
  static const double px12 = 12;
  static const double px16 = 16;
  static const double px20 = 20;
  static const double px24 = 24;
  static const double px32 = 32;
  static const double px40 = 40;

  /// Defaults size button
  static const double buttonSize = 40;

  /// Defaults size signature in pdf
  static const double signatureSize = 400;

  static final BorderRadius br_4 = BorderRadius.circular(px4);
  static final BorderRadius br_8 = BorderRadius.circular(px8);
  static final BorderRadius br_12 = BorderRadius.circular(px12);
  static final BorderRadius br_16 = BorderRadius.circular(px16);
  static final BorderRadius br_24 = BorderRadius.circular(px24);

  static const BorderRadius brTop_4 = BorderRadius.vertical(top: Radius.circular(px4));
  static const BorderRadius brTop_8 = BorderRadius.vertical(top: Radius.circular(px8));
  static const BorderRadius brTop_12 = BorderRadius.vertical(top: Radius.circular(px12));
  static const BorderRadius brTop_16 = BorderRadius.vertical(top: Radius.circular(px16));

  static const BorderRadius brBottom_4 = BorderRadius.vertical(bottom: Radius.circular(px4));
  static const BorderRadius brBottom_8 = BorderRadius.vertical(bottom: Radius.circular(px8));
  static const BorderRadius brBottom_12 = BorderRadius.vertical(bottom: Radius.circular(px12));
  static const BorderRadius brBottom_16 = BorderRadius.vertical(bottom: Radius.circular(px16));

  static final RoundedRectangleBorder roundedBorder_4 = RoundedRectangleBorder(borderRadius: br_4);
  static final RoundedRectangleBorder roundedBorder_8 = RoundedRectangleBorder(borderRadius: br_8);
  static final RoundedRectangleBorder roundedBorder_12 = RoundedRectangleBorder(borderRadius: br_12);
  static final RoundedRectangleBorder roundedBorder_16 = RoundedRectangleBorder(borderRadius: br_16);
  static final RoundedRectangleBorder roundedBorder_24 = RoundedRectangleBorder(borderRadius: br_24);

  static Size size = const Size(375, 667); // Size of Iphone SE

  static double get width => size.width;

  static double get height => size.height;

  static bool get isMobile => size.width < 600;

  static bool get isTablet => size.width >= 600 && size.width < 1024;

  static bool get isDesktop => size.width >= 1024 && size.width < 1920;

  static bool get isUltraWideDesktop => size.width >= 1920;

  static bool get isDesktopOrUltra => isDesktop || isUltraWideDesktop;

  static String get typeDevice {
    if (isMobile) return 'MOBILE';
    if (isTablet) return 'TABLET';
    if (isDesktop) return 'DESKTOP';
    if (isUltraWideDesktop) return 'ULTRAWIDE';
    return '';
  }
}
