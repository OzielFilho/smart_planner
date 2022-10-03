import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class ThemeApp {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: ColorUtils.primaryColor,
      backgroundColor: ColorUtils.primaryColor,
      buttonTheme: const ButtonThemeData(buttonColor: ColorUtils.whiteColor),
      scaffoldBackgroundColor: ColorUtils.primaryColor,
      fontFamily: 'Poppins',
      appBarTheme: const AppBarTheme(color: ColorUtils.primaryColor),
      textTheme: const TextTheme(
          caption: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorUtils.whiteColor),
          overline: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorUtils.primaryColor),
          subtitle1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: ColorUtils.whiteColor),
          headline1: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorUtils.whiteColor),
          headline2: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: ColorUtils.whiteColor),
          headline3: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorUtils.whiteColor),
          button: TextStyle(
              fontWeight: FontWeight.bold, color: ColorUtils.primaryColor)),
    );
  }
}
