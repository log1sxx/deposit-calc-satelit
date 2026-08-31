import 'package:flutter/material.dart';
import 'package:deposit_calc_satelit/core/theme/app_colors.dart';

final defaultTheme = ThemeData(
  appBarTheme: appBarTheme,
  fontFamily: 'SFProDisplay',
  inputDecorationTheme: inputDecorationTheme,
  bottomNavigationBarTheme: bottomNavBarTheme,
  buttonTheme: buttonThemeData,
  colorScheme: ColorScheme(
    primaryContainer: AppColors.white.withOpacity(0.15),
    secondaryContainer: AppColors.white.withOpacity(0.1),
    onSecondaryContainer: AppColors.white,
    brightness: Brightness.dark,
    primary: AppColors.primaryBlue,
    onPrimary: AppColors.white,
    secondary: AppColors.secondaryBlue,
    onSecondary: AppColors.black,
    error: AppColors.white,
    onError: AppColors.white,
    surface: AppColors.white,
    onSurface: Colors.black,
  ),
);

var buttonThemeData = const ButtonThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.green,
    onPrimary: AppColors.white,
    secondary: AppColors.white,
    onSecondary: AppColors.white,
    error: AppColors.white,
    onError: AppColors.white,
    surface: AppColors.white,
    onSurface: Colors.white,
  ),
);

var bottomNavBarTheme = BottomNavigationBarThemeData(
  /* selectedLabelStyle: UIFonts.selectedLabelStyle,
    unselectedLabelStyle:
        UIFonts.selectedLabelStyle.copyWith(color: AppColors.white.withOpacity(0.6)), */
  selectedItemColor: AppColors.orange,
  unselectedItemColor: AppColors.white.withOpacity(0.6),
);

var appBarTheme = const AppBarTheme(
  backgroundColor: AppColors.secondaryBlue,
  surfaceTintColor: AppColors.secondaryBlue,
);

var inputDecorationTheme = InputDecorationTheme(
  fillColor: AppColors.fillColor,
  errorStyle: const TextStyle(color: Colors.red, height: 2),
  isDense: true,
  border: defaultBorder,
  iconColor: AppColors.orange,
  enabledBorder: defaultBorder,
  focusedBorder: focusedBorder,
  focusedErrorBorder: errorBorder,
  errorBorder: errorBorder,
);

var errorBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 0, color: Colors.transparent),
  borderRadius: BorderRadius.circular(20),
);
var focusedBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: AppColors.green),
  borderRadius: BorderRadius.circular(20),
);
var defaultBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: Colors.transparent),
  borderRadius: BorderRadius.circular(20),
);
