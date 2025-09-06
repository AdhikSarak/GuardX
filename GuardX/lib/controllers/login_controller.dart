import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/strings.dart';
import 'package:guardx/routes/route_helper.dart';
import 'package:guardx/utils/helper/helper.dart';
import 'package:guardx/views/home_screen/home.dart';
import 'package:guardx/widgets/show_lockout_screen.dart';
import 'email_send_controller.dart';
import 'package:dargon2_flutter/dargon2_flutter.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final EmailService emailService = EmailService();
  // final UserController userController = Get.lazyPut(() => UserController());
  var isLoading = false.obs;
  static const int firstLockoutThreshold = 2;
  static const int secondLockoutThreshold = 3;
  static const int thirdLockoutThreshold = 4;
  static const Duration firstLockoutDuration = Duration(seconds: 60);
  static const Duration secondLockoutDuration = Duration(seconds: 120);
  static const Duration thirdLockoutDuration = Duration(seconds: 200);

 Future<void> login(String email, String password) async {
  logger.i("Logging in user $email");

  isLoading.value = true;
  final Timestamp now = Timestamp.now();
  final DocumentReference attemptsRef = _firestore.collection('loginAttempts').doc(email);

  try {
    final lockoutStatus = await _checkLockoutStatus(attemptsRef, now);
    if (lockoutStatus != null) {
      isLoading.value = false;
      return;
    }

    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    addMainKeyToSecuredStorage(email, password);

    final String uid = userCredential.user!.uid;
    final DocumentReference userDocRef = _firestore.collection('users').doc(uid);

    // Check if the user document exists
    DocumentSnapshot userDoc = await userDocRef.get();
    if (userDoc.exists) {
      // Update existing user document
      await userDocRef.update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Create new user document if it doesn't exist
      await userDocRef.set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'isTwoFactorEnabled': false,
        // 'secondaryKey': await fetchSecondaryKeyFromFirestore(email) ?? '',
      });
    }

    await _resetLoginAttempts(attemptsRef);
    Get.offNamed(RouteHelper.home); //move to home screen
  } on FirebaseAuthException catch (e) {
    await _handleFailedLoginAttempt(attemptsRef, e, email);
  } finally {
    isLoading.value = false;
  }
}


  Future<DateTime?> _checkLockoutStatus(
      DocumentReference attemptsRef, Timestamp now) async {
    final DocumentSnapshot snapshot = await attemptsRef.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final int attempts = data['attempts'] ?? 0;
      final Timestamp firstAttempt = data['firstAttempt'] ?? now;

      final Duration difference =
          now.toDate().difference(firstAttempt.toDate());
      print("difference: $difference and attempt: $attempts");
      if (attempts >= thirdLockoutThreshold &&
          difference < thirdLockoutDuration) {
        return firstAttempt.toDate().add(thirdLockoutDuration);
      } else if (attempts >= secondLockoutThreshold &&
          difference < secondLockoutDuration) {
        return firstAttempt.toDate().add(secondLockoutDuration);
      } else if (attempts >= firstLockoutThreshold &&
          difference < firstLockoutDuration) {
        return firstAttempt.toDate().add(firstLockoutDuration);
      } else if (difference >= thirdLockoutDuration) {
        await _resetLoginAttempts(attemptsRef);
      }
    }
    return null;
  }

  Future<void> _resetLoginAttempts(DocumentReference attemptsRef) async {
    await attemptsRef.delete();
  }

  Future<void> _handleFailedLoginAttempt(DocumentReference attemptsRef,
      FirebaseAuthException e, String email) async {
    try {
      final DocumentSnapshot snapshot = await attemptsRef.get();
      final int attempts = snapshot.exists
          ? (snapshot.data() as Map<String, dynamic>)['attempts'] + 1
          : 1;
      final Timestamp firstAttempt = snapshot.exists
          ? (snapshot.data() as Map<String, dynamic>)['firstAttempt']
          : Timestamp.now();

      await attemptsRef
          .set({'attempts': attempts, 'firstAttempt': firstAttempt});

      if (attempts >= thirdLockoutThreshold) {
        _navigateToLockoutScreen(firstAttempt
            .toDate()
            .add(thirdLockoutDuration)
            .millisecondsSinceEpoch);
      } else if (attempts >= secondLockoutThreshold) {
        _navigateToLockoutScreen(firstAttempt
            .toDate()
            .add(secondLockoutDuration)
            .millisecondsSinceEpoch);
      } else if (attempts >= firstLockoutThreshold) {
        _navigateToLockoutScreen(firstAttempt
            .toDate()
            .add(firstLockoutDuration)
            .millisecondsSinceEpoch);
        await emailService.sendEmail(
            toEmail: email,
            subject: AppText.emailSubject,
            body: AppText.emailBody);
      } else {
        _showFirebaseAuthError(e);
      }
    } catch (error) {
      print("Failed to handle failed login attempt: $error");
      _showFirebaseAuthError(e);
    }
  }

  Future<void> _showFirebaseAuthError(FirebaseAuthException e) async {
    logger.i(
        "_showFirebaseAuthError FirebaseAuthException ${e.message} ${e.code}");
    switch (e.code) {
      case AppText.authExceptionUserNotFound:
        Get.snackbar(
          AppText.error,
          AppText.authExceptionUserNotFoundMessage,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        break;
      case AppText.multiFactorAuthRequired:
        Get.snackbar(
          AppText.error,
          e.message.toString(),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        break;
      case AppText.authExceptionWrongPassword:
        Get.snackbar(
          AppText.error,
          AppText.authExceptionWrongPasswordMessage,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        break;
      case AppText.mfaRequiredcode:
        {
          var userCredential = FirebaseAuth.instance.currentUser;
          await userCredential?.sendEmailVerification();
          Get.snackbar(
            AppText.mfaRequiredcode,
            AppText.mfaAuthMessage,
            backgroundColor: Colors.orange,
            snackPosition: SnackPosition.TOP,
          );
        }
        break;
      default:
        Get.snackbar(
          AppText.error,
          '${AppText.loginFaild} ${e.message}',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        break;
    }
  }

  void _navigateToLockoutScreen(int endTime) {
    Get.to(() => LockoutScreen(endTime: endTime));
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
  //     salt:
  //         "crewhub", // Static salt (consider a randomly generated salt for security)
  //     rounds: 10000, // Number of iterations for security
  //   );
  //   print("generated Secondary key :$hash");
  //   return hash.toString(); // Return hashed password
  // }

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
