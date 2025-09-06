import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:dargon2_flutter/dargon2_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/services/firebase_services.dart';

class AccountController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isChangePasswordLoading = false.obs;

// bool areDetailsFilled() {
//     return oldPasswordController.text.isNotEmpty &&
//         newPasswordController.text.isNotEmpty &&
//         confirmPasswordController.text.isNotEmpty;
//   }

  // bool validateNewPass() {
  //   return newPasswordController.text == confirmPasswordController.text &&
  //       newPasswordController.text.length >= 8; // Add custom validation logic
  // }

  bool areDetailsFilled() {
    if (oldPasswordController.text.isNotEmptyAndNotNull &&
        newPasswordController.text.isNotEmptyAndNotNull &&
        confirmPasswordController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool validateNewPass() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(newPasswordController.text);
  }

  Future<void> changePassword(BuildContext context) async {
    try {
      // Check if currentUser is null
      if (currentUser == null) {
        throw Exception("No user is currently signed in.");
      }

      final email = currentUser!.email!;
      final cred = EmailAuthProvider.credential(
        email: email,
        password: oldPasswordController.text,
      );

      isChangePasswordLoading(true); // Start loading

      // Reauthenticate the user
      await currentUser!.reauthenticateWithCredential(cred);

      // Update the password
      await currentUser!.updatePassword(newPasswordController.text);

      // Handle post-password-change logic
      await decryptAllSecrets(context);

      VxToast.show(context, msg: "Password changed successfully!");
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'wrong-password':
          errorMessage = "The old password is incorrect.";
          break;
        case 'weak-password':
          errorMessage = "The new password is too weak.";
          break;
        default:
          errorMessage = e.message ?? "An error occurred.";
      }

      VxToast.show(context, msg: errorMessage);
    } on Exception catch (e) {
      VxToast.show(context, msg: e.toString());
    } finally {
      isChangePasswordLoading(false); // Stop loading
    }
  }

  decryptAllSecrets(context) async {
    const storage = FlutterSecureStorage();
    String? oldKey = await storage.read(key: mainKey);
    QuerySnapshot secrets =
        await FirebaseServices.getAllSecrets(currentUser!.uid);

    String? ivStr = await storage.read(key: ivKey);
    encrypt.Key key = encrypt.Key.fromBase16(oldKey!.substring(0, 64));
    encrypt.IV iv = encrypt.IV.fromBase16(ivStr!);

    encrypt.Encrypter encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));

    String newSecondaryKey = await generateSecondaryKey(
        currentUser!.email.toString(), newPasswordController.text);
    String newMainKey = generateMainKey(newSecondaryKey);
    encrypt.Key encryptionKey = encrypt.Key.fromBase16(newSecondaryKey);
    final newiv = encrypt.IV.fromBase16(encryptionKey.base16);
    encrypt.Key newkey = encrypt.Key.fromBase16(newMainKey.substring(0, 64));
    encrypt.Encrypter newEncrypter =
        encrypt.Encrypter(encrypt.AES(newkey, mode: encrypt.AESMode.gcm));

    for (int i = 0; i < secrets.docs.length; i++) {
      var secret = Map<String, dynamic>.from(secrets.docs[i].data() as Map);
      String? pass = secret['p_password'];
      encrypt.Encrypted encrypted =
          encrypt.Encrypted(encrypt.decodeHexString(pass!));
      String decrypted = encrypter.decrypt(encrypted, iv: iv);

      encrypt.Encrypted newEncrypted =
          newEncrypter.encrypt(decrypted, iv: newiv);

      var docId = secrets.docs[i].id;
      var store = firestore.collection(passwords).doc(docId);
      await store.set({
        'p_password': newEncrypted.base16,
      }, SetOptions(merge: true));
    }

    storage.write(key: ivKey, value: newiv.base16);
    storage.write(key: mainKey, value: newMainKey);
    storage.write(key: secondaryKey, value: newSecondaryKey);

    oldPasswordController.clear();
    newPasswordController.clear();
    isChangePasswordLoading(false);
    VxToast.show(context, msg: passwordUpdatedSuccessfully.tr);
    Get.back();
  }
}

Future<String> generateSecondaryKey(email, password) async {
  Salt salt = Salt(utf8.encode(crewhub));
  //salt
  String inputData = "$email$password";
  DArgon2Result result = await argon2.hashPasswordString(inputData,
      salt: salt, type: Argon2Type.id);
  return result.hexString;
}

// Future<String> generateSecondaryKey(String email, String password) async {
//   String inputData = "$email$password";

//   // Use Argon2id for hashing
//   final hash = Crypt.sha256(
//     inputData,
//     salt: "crewhub", // Static salt (consider a randomly generated salt for security)
//     rounds: 10000, // Number of iterations for security
//   );

//   return hash.toString(); // Return hashed password
// }

String generateMainKey(key) {
  //master key
  encrypt.Key encryptionKey = encrypt.Key.fromBase16(key);
  final iv = encrypt.IV.fromBase16(encryptionKey.base16);
  //iv
  const storage = FlutterSecureStorage();
  storage.write(key: ivKey, value: iv.base16);
  final encrypter =
      encrypt.Encrypter(encrypt.AES(encryptionKey, mode: encrypt.AESMode.gcm));
  final encrypted = encrypter.encrypt(masterKey, iv: iv);
  return encrypted.base16;
}
