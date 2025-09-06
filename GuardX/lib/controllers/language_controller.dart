import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';

class LanguageController extends GetxController {
  var returnTrue = Get.deviceLocale != null ? true.obs : false.obs;
  //Changing the Language
  void changeLanguage(var lang, var country) {
    var locale = Locale(lang, country);
    print("Done");
    Get.updateLocale(locale);
  }
}
 
 
