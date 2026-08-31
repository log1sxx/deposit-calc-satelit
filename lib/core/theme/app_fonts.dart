import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class TextStyles {
  static String fontFamily = 'SFProDisplay';
  static double textHeight = 1.2;

  static TextStyle h2 = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );

  static const body16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.35,
    color: Colors.black,
  );

  static const headerTitle = TextStyle(
    fontFamily: 'Gilroy',
    fontFamilyFallback: ['SFProDisplay'],
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
