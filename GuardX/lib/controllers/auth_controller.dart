import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
// import 'package:dargon2_flutter/dargon2_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/consts/strings.dart';  

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late Rxn<User?> firebaseUser;
  var isEmailValid = false.obs;
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rxn<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  Future<void> _sendAlertEmail(String email) async {
    // Implement email sending logic here
    // This could use a backend service like Firebase Cloud Functions, SendGrid, or any other email service provider
    print('Sending alert email to $email');
  }

  // method for checking user have created account already or not
  Future<bool> checkIfEmailExists(String email) async {
    final result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isNotEmpty;
  }

  // method for checking email is valid or not
  void checkEmailValidity(String email) {
    isEmailValid.value = GetUtils.isEmail(email);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void addMainKeyToSecuredStorage(email, password) async {
    const storage = FlutterSecureStorage();
    String secondaryKeyValue = await generateSecondaryKey(email, password);
    await storage.write(key: secondaryKey, value: secondaryKeyValue);

    String encryptingKey = secondaryKeyValue;
    String mainKeyValue = generateMainKey(encryptingKey);
    await storage.write(key: mainKey, value: mainKeyValue);
    Map<String, String> all = await storage.readAll();
  }
 
 
 Future<String> generateSecondaryKey(String email, String password) async {
  String inputData = "$email$password";

  // Use Argon2id for hashing
  final hash = Crypt.sha256(
    inputData,
    salt: "crewhub", // Static salt (consider a randomly generated salt for security)
    rounds: 10000, // Number of iterations for security
  );

  return hash.toString(); // Return hashed password
}


  String generateMainKey(key) {
    //master key
    encrypt.Key encryptionKey = encrypt.Key.fromBase16(key);
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
