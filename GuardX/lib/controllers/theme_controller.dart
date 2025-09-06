import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Icon themeIcon = const Icon(Icons.wb_sunny_outlined);
  var isDarkTheme = Get.isDarkMode.obs;

  //Changing the Theme
  toDarkTheme() {
    Get.changeThemeMode(ThemeMode.dark);
    isDarkTheme(true);
  }

  toLightTheme() {
    Get.changeThemeMode(ThemeMode.light);
    isDarkTheme(false);
  }
}
