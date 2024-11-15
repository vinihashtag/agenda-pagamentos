import 'app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';

import 'app_colors.dart';
import 'app_typography.dart';

final class AppTheme {
  AppTheme._();

  /// Theme default of app
  static ThemeData get defaultTheme => ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        disabledColor: AppColors.disabled,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surfaceTint: Colors.white,
          error: AppColors.error,
          onError: AppColors.error,
        ),
        textTheme: AppTypography.textTheme,
        textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.primary),
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.statusBar,
            statusBarBrightness: GetPlatform.isAndroid ? Brightness.light : Brightness.dark,
            statusBarIconBrightness: GetPlatform.isAndroid ? Brightness.light : Brightness.dark,
          ),
          // elevation: 0,
          centerTitle: true,
          titleSpacing: 0,
          titleTextStyle: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actionIconTheme: ActionIconThemeData(
          backButtonIconBuilder: (context) => Icon(
            Icons.adaptive.arrow_back_rounded,
            color: Colors.black54,
          ),
          closeButtonIconBuilder: (context) => const Icon(
            Icons.close_rounded,
            color: Colors.black54,
          ),
        ),
        inputDecorationTheme: _defaultInputDecoration,
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: _defaultInputDecoration,
          menuStyle: const MenuStyle(shadowColor: WidgetStatePropertyAll(AppColors.secondary)),
        ),
        textButtonTheme:
            const TextButtonThemeData(style: ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent))),
        popupMenuTheme: const PopupMenuThemeData(surfaceTintColor: Colors.white),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.disabled) ? AppColors.disabled : AppColors.secondary),
          ),
        ),
        tabBarTheme: TabBarTheme(
            dividerColor: Colors.grey,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            labelStyle: AppTypography.bodyText2.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              height: 1.1,
              letterSpacing: 1.2,
            ),
            unselectedLabelStyle: AppTypography.bodyText2.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              height: 1.1,
              letterSpacing: 1.2,
            ),
            indicatorSize: TabBarIndicatorSize.tab),
      );

  static InputDecorationTheme get _defaultInputDecoration => InputDecorationTheme(
        errorStyle: AppTypography.bodyText2.copyWith(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.w500),
        hintStyle: AppTypography.bodyText2.copyWith(color: AppColors.hint),
        errorMaxLines: 2,
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        prefixIconColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.error)) return AppColors.error;
          return states.contains(WidgetState.focused) ? AppColors.primary : AppColors.disabled;
        }),
        suffixIconColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.error)) return AppColors.error;
          return states.contains(WidgetState.focused) ? AppColors.greyDark.withOpacity(.8) : AppColors.disabled;
        }),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSizes.br_12,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AppSizes.br_12,
          borderSide: const BorderSide(color: AppColors.disabled, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSizes.br_12,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSizes.br_12,
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSizes.br_12,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hoverColor: Colors.transparent,
      );
}
