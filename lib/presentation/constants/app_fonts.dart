import 'package:flutter/material.dart';
import 'package:tractian/presentation/constants/app_colors.dart';

class AppTextStyle {
  final TextStyle Function(Color) customColor;
  final Color Function(BuildContext) _defaultThemedColor;

  const AppTextStyle(this.customColor, this._defaultThemedColor);

  TextStyle defaultStyle(BuildContext context) {
    return customColor(_defaultThemedColor(context));
  }
}

AppTextStyle regularSm = AppTextStyle(
      (color) => TextStyle(
    decoration: TextDecoration.none,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: color,
    fontSize: 14,
    height: 2.0,
  ),
      (context) => AppColors.neutralGray500,
);

AppTextStyle bodyRegular = AppTextStyle(
      (color) => TextStyle(
    decoration: TextDecoration.none,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: color,
    fontSize: 14,
    height: 2.2,
  ),
      (context) => AppColors.neutralGray500,
);
