import 'package:flutter/material.dart';

const height = 1.2;

abstract class AppStyles {
  static const primary = Color(0xFF4E88F4);
  static const secondary = Color(0xFF000AFF);
  static const scaffold = Color(0xFFFCFCFC);
  static const appBarBackgroundColor = Color(0xFFEAECEE);

  static const greyDark = Color(0xFF1B1B1B);
  static const grey = Color(0xFF2A2A2A);
  static const light = Color(0xFFF2F2F2);

  static const storyLiteracyColorOne = Color(0xFF1771F0);
  static const storyLiteracyColorTwo = Color(0xFF4189F6);

  static const storyInvestingColorOne = Color(0xFF8011D0);
  static const storyInvestingColorTwo = Color(0xFF9F42FD);

  static const storyFraudColorOne = Color(0xFF409987);
  static const storyFraudColorTwo = Color(0xFF0B3A3A);

  static const darkColorOne = Color(0xFF232526);
  static const darkColorTwo = Color(0xFF414345);

  static const formOutline = Color(0xFFFFEAEA);

  static const lightGreen = Color(0xFFEBFF00);
  static const beige = Color(0xffFEFFB8);
  static const yellow = Color(0xFFFFFA03);

  static const offersBackground = Color(0xFFE6E6E6);

  static const storyTitle = TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.1,
  );

  static const storyText = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const h1 = TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: height,
  );

  static const h2 = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: height,
  );

  static const body = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: height,
  );

  static const display = TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
}
