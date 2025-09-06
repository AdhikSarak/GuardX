import 'package:get/get.dart';
import 'dart:math';

class PasswordGenerateController extends GetxController {
  var generatedPassword = ''.obs;
  var passwordLength = 6.obs;
  var includeUpperCase = true.obs;
  var includeLowerCase = true.obs;
  var includeNumbers = true.obs;
  var includeSymbols = true.obs;

  void toggleUpperCase(bool value) => includeUpperCase.value = value;
  void toggleLowerCase(bool value) => includeLowerCase.value = value;
  void toggleNumbers(bool value) => includeNumbers.value = value;
  void toggleSymbols(bool value) => includeSymbols.value = value;

  void increasePasswordLength() {
    if (passwordLength.value < 16) passwordLength.value++;
  }

  void decreasePasswordLength() {
    if (passwordLength.value > 6) passwordLength.value--;
  }

  void generatePassword() {
    const upperCaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowerCaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()-_=+[]{}|;:,.<>?';

    String chars = '';
    if (includeUpperCase.value) chars += upperCaseLetters;
    if (includeLowerCase.value) chars += lowerCaseLetters;
    if (includeNumbers.value) chars += numbers;
    if (includeSymbols.value) chars += symbols;

    generatedPassword.value = List.generate(passwordLength.value, (index) {
      final randomIndex = Random().nextInt(chars.length);
      return chars[randomIndex];
    }).join();
  }

  void copyPassword() {
    // Logic for copying password to clipboard
  }

  void refreshPassword() {
    generatePassword();
  }
}
