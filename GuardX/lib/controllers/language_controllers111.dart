
import 'dart:ui';
import 'package:get/get.dart'; 
class LanguageControllers111 extends GetxController {
  var selectedLanguage = 'English'.obs;

  void changeLanguage(String language) {
    selectedLanguage.value = language;
    // Update the app's locale based on the selected language
    if (language == 'English') {
      Get.updateLocale(const Locale('en', 'US'));
    } else if (language == 'Hindi') {
      Get.updateLocale(const Locale('hi', 'IN'));
    } else if (language == 'Marathi') {
      Get.updateLocale(const Locale('mr', 'IN'));
    } else if (language == 'Gujarati') {
      Get.updateLocale(const Locale('gu', 'IN'));
    }
  }

  void saveLanguage() {
    // Save the selected language to persistent storage if needed
    // Example: Save the selected language to SharedPreferences
    // This can be done to remember the selected language across app restarts
  }
}
