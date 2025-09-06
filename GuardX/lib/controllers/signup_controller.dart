import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/views/home_screen/home.dart';
import 'package:uuid/uuid.dart';
import '../utils/helper/helper.dart';
import 'package:dargon2_flutter/dargon2_flutter.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var sessionId = const Uuid().v4();

  Future<void> signUp(String email, String password) async {
    logger.i("Signing up user with email $email");

    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      addMainKeyToSecuredStorage(email, password);
      User? user = userCredential.user;
      logger.i("User Created!! Saving details");

      await _firestore.collection('users').doc(user?.uid).set({
        'email': email,
        'createdAt': Timestamp.now().toDate(),
        'isTwoFactorEnabled': false,
        'sessionId': sessionId,
      });
      logger.i("Verification email sent!!");
      await user?.sendEmailVerification();
      Get.snackbar(
        backgroundColor: Colors.green,
        AppText.success,
        "${AppText.verificationEmail} ${user?.email}. ${AppText.checkYourInbox}",
      );

      Get.to(() => Home());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        backgroundColor: Colors.red,
        AppText.failedTosendOTP,
        "${AppText.verificationEmail} ${e.toString()}",
      );
      errorMessage.value = handleAuthException(e);
    } finally {
      isLoading.value = false;
    }
  }

  String handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return '\u24d8 This email is already in use.';
      case 'invalid-email':
        return '\u24d8 The email address is not valid.';
      case 'operation-not-allowed':
        return '\u24d8 Email/Password accounts are not enabled.';
      case 'weak-password':
        return '\u24d8 The password is too weak.';
      default:
        return '\u24d8 An unknown error occurred. Please try again.';
    }
  }

  void addMainKeyToSecuredStorage(email, password) async {
    const storage = FlutterSecureStorage();
    String secondaryKeyValue = await generateSecondaryKey(email, password);
    await storage.write(key: secondaryKey, value: secondaryKeyValue);

    String encryptingKey = secondaryKeyValue;
    String mainKeyValue = generateMainKey(encryptingKey);
    await storage.write(key: mainKey, value: mainKeyValue);
    Map<String, String> all = await storage.readAll();
    print(all);
  }

  // Future<String> generateSecondaryKey(String email, String password) async {
  //   String inputData = "$email$password";

  //   // Use Argon2id for hashing
  //   final hash = Crypt.sha256(
  //     inputData,
  //     salt:
  //         "crewhub", // Static salt (consider a randomly generated salt for security)
  //     rounds: 10000, // Number of iterations for security
  //   );
  //   print("generated secondary key : $hash & ${hash.toString()}");
  //   return hash.toString(); // Return hashed password
  // }
  Future<String> generateSecondaryKey(email, password) async {
  Salt salt = Salt(utf8.encode(crewhub));
  //salt
  String inputData = "$email$password";
  DArgon2Result result = await argon2.hashPasswordString(inputData,
      salt: salt, type: Argon2Type.id);
  return result.hexString;
}

  String generateMainKey(key) {
    //master key
    encrypt.Key encryptionKey = encrypt.Key.fromBase16(key);
    print(encryptionKey.length);
    final iv = encrypt.IV.fromBase16(encryptionKey.base16);
    //iv
    const storage = FlutterSecureStorage();
    storage.write(key: ivKey, value: iv.base16);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(encryptionKey, mode: encrypt.AESMode.gcm));
    final encrypted = encrypter.encrypt(masterKey, iv: iv);
    return encrypted.base16;
  }
}
