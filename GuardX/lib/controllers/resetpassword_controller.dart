
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/strings.dart';

class PasswordResetController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(AppText.success, AppText.passwordReset, snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar(AppText.error, e.toString(), snackPosition: SnackPosition.TOP);
    }
  }
}


