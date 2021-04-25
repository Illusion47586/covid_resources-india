import 'package:covid_resources/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ThemeHandler {
  static const String fontFamily = 'manrope';

  static ThemeData themeData = ThemeData(
    fontFamily: fontFamily,
    primaryColor: Colors.blue,
    accentColor: AppColors.accentGreenDark,
    backgroundColor: AppColors.light,
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 40,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        alignment: Alignment.center,
        enableFeedback: true,
        overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
        elevation: MaterialStateProperty.all(20),
        shadowColor: MaterialStateProperty.all(Colors.black12),
      ),
    ),
    brightness: Brightness.light,
  );
}
