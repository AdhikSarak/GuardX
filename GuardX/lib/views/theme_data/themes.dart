import 'package:flutter/material.dart';
import 'package:guardx/consts/colors.dart';
import 'package:guardx/consts/styles.dart';

class Themes {
  ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: blueColor,
      ),
  );

  ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        primary: mainColor,
        brightness: Brightness.dark,
        seedColor: blueColor,
        tertiaryContainer: darkFontGrey,
      ),
      fontFamily: regular,
  );
}
