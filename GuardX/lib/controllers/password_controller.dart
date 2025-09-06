 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';  
import 'package:guardx/consts/index.dart';

class PasswordController extends GetxController {
  // Text Editing Controllers
  TextEditingController pWebsiteNameController = TextEditingController();
  TextEditingController pWebsiteLinkController = TextEditingController();
  TextEditingController pEmailUsernameController = TextEditingController();
  TextEditingController pPasswordController = TextEditingController();

  late TextEditingController pWebsiteNameEditingController;
  late TextEditingController pWebsiteLinkEditingController;
  late TextEditingController pEmailUsernameEditingController;
  late TextEditingController pPasswordEditingController;

  // Reactive Variables
  var readOnlyPasswordDetails = true.obs;
  var updatePasswordIsLoading = false.obs;
  var addPasswordIsLoading = false.obs;
  var isFav = false.obs;
  var savedPasswordCount = 0.obs;
  var passwords = <QueryDocumentSnapshot>[].obs;

  // Get current user's UID
  final String userId = currentUser!.uid;

  // Collection references
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  CollectionReference get passwordCollection => userCollection
      .doc(userId)
      .collection('passwords'); // Access passwords subcollection

  @override
  void onInit() {
    super.onInit();
    fetchSavedPasswordCount();
    fetchPasswords();
  }

  Future<void> fetchPasswords() async {
    try {
      passwordCollection.snapshots().listen((snapshot) {
        passwords.value = snapshot.docs;
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch passwords: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error fetching passwords: $e");
    }
  }

  void updateWebsiteName(String url) {
       pWebsiteNameController.text = url;
        update();  
      }

  Future<void> fetchSavedPasswordCount() async {
    try {
      QuerySnapshot querySnapshot = await passwordCollection.get();
      savedPasswordCount.value = querySnapshot.docs.length;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch password count: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error fetching password count: $e");
    }
  }

  // Function to Encrypt Password
  Future<String> encryptSecret(password) async {
    try {
      const storage = FlutterSecureStorage();
      var mainKeyValue = await storage.read(key: mainKey);
      var ivStr = await storage.read(key: ivKey);

      encrypt.Key key = encrypt.Key.fromBase16(mainKeyValue!.substring(0, 64));
      final iv = encrypt.IV.fromBase16(ivStr!);

      encrypt.Encrypter encrypter =
          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
      encrypt.Encrypted encrypted = encrypter.encrypt(password, iv: iv);
      return encrypted.base16;
    } catch (e) {
      Get.snackbar("Error", "Failed to encrypt password: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error encrypting secret: $e");
      rethrow;
    }
  }

  // Function to Decrypt Password
  Future<String> decryptSecret(password) async {
    try {
      const storage = FlutterSecureStorage();
      String? mainKeyValue = await storage.read(key: mainKey);
      String? ivStr = await storage.read(key: ivKey);

      encrypt.Key key = encrypt.Key.fromBase16(mainKeyValue!.substring(0, 64));
      encrypt.IV iv = encrypt.IV.fromBase16(ivStr!);

      encrypt.Encrypter encrypter =
          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
      encrypt.Encrypted encrypted =
          encrypt.Encrypted(encrypt.decodeHexString(password));
      String decrypted = encrypter.decrypt(encrypted, iv: iv);
      return decrypted;
    } catch (e) {
      Get.snackbar("Error", "Failed to decrypt password: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error decrypting secret: $e");
      rethrow;
    }
  }

  // Function to Add Password
  Future<void> addPassword(context) async {
    try {
      addPasswordIsLoading(true);
      var store = passwordCollection.doc();
      String encryptedPassword = await encryptSecret(pPasswordController.text);
      
      await store.set({
        'p_user': currentUser!.uid,
        'p_website_name': pWebsiteNameController.text,
        'p_website_link': pWebsiteLinkController.text,
        'p_email_username': pEmailUsernameController.text,
        'p_password': encryptedPassword,
        'p_favourites': false,
        'p_created_At': FieldValue.serverTimestamp(),
        'p_updated_at': FieldValue.serverTimestamp(),
        'p_tags': FieldValue.arrayUnion(['Education', 'Social']),
      });

      pWebsiteNameController.clear();
      pWebsiteLinkController.clear();
      pEmailUsernameController.clear();
      pPasswordController.clear();

      addPasswordIsLoading(false);
      savedPasswordCount.value++; // Increment password count
      Get.snackbar("Success", "Password added successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      addPasswordIsLoading(false);
      Get.snackbar("Error", "Failed to add password: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error adding password: $e");
    }
  }

  // Function to Update Password
  Future<void> updatePassword(docId) async {
    try {
      updatePasswordIsLoading(true);
      var store = passwordCollection.doc(docId);
      String encryptedPassword =
          await encryptSecret(pPasswordEditingController.text);

      await store.set({
        'p_email_username': pEmailUsernameEditingController.text,
        'p_password': encryptedPassword,
        'p_website_link': pWebsiteLinkEditingController.text,
        'p_updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      updatePasswordIsLoading(false);
      Get.snackbar("Success", "Password updated successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      updatePasswordIsLoading(false);
      Get.snackbar("Error", "Failed to update password: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error updating password: $e");
    }
  }

  // Function to Delete Password
  Future<void> deletePassword(docId) async {
    try {
      await passwordCollection.doc(docId).delete();
      savedPasswordCount.value--; // Decrement password count
      Get.snackbar("Success", "Password deleted successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete password: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error deleting password: $e");
    }
  }

  // Function to Add to Favorites
  Future<void> addToFavourite(context, docId) async {
    try {
      await passwordCollection.doc(docId).set({
        'p_favourites': true,
      }, SetOptions(merge: true));
      isFav(true);
      VxToast.show(context, msg: addedToFavourites.tr);
    } catch (e) {
      Get.snackbar("Error", "Failed to add to favorites: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error adding to favourites: $e");
    }
  }

  // Function to Remove from Favorites
  Future<void> removeFromFavourite(context, docId) async {
    try {
      await passwordCollection.doc(docId).set({
        'p_favourites': false,
      }, SetOptions(merge: true));
      isFav(false);
      VxToast.show(context, msg: removedFromFavourites.tr);
    } catch (e) {
      Get.snackbar("Error", "Failed to remove from favorites: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error removing from favourites: $e");
    }
  }

  Future<void> checkIfFavourite(data) async {
    try {
      isFav(data['p_favourites'] ?? false);
    } catch (e) {
      Get.snackbar("Error", "Failed to check favorite status: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print("Error checking favourite status: $e");
    }
  }
}
