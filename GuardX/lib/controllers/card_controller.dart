import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:guardx/consts/index.dart';

class CardController extends GetxController {
  // Controllers for input fields
  TextEditingController bankNameController = TextEditingController();
  TextEditingController cardHoldersNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardPinController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardTypeController = TextEditingController();
  TextEditingController expiryMonthController = TextEditingController();
  TextEditingController expiryYearController = TextEditingController();

  // Controllers for editing fields
  late TextEditingController bankNameEdittingController;
  late TextEditingController cardHoldersNameEdittingController;
  late TextEditingController cardNumberEdittingController;
  late TextEditingController cardPinEdittingController;
  late TextEditingController cvvEdittingController;
  late TextEditingController cardTypeEdittingController;
  late TextEditingController expiryMonthEdittingController;
  late TextEditingController expiryYearEdittingController;

  // Reactive variables
  var addCardIsLoading = false.obs;
  var updateCardIsLoading = false.obs;
  var isFav = false.obs;
  var readOnlyCardDetails = true.obs;
  var savedCardCount = 0.obs; // Reactive variable for card count

  //List to hold the Cards
  var cards = <QueryDocumentSnapshot>[].obs;

  // Get current user's UID
  final String userId = currentUser!.uid;

  // Collection reference for storing cards
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  CollectionReference get cardCollection => userCollection
      .doc(userId)
      .collection('cards'); // Access notes subcollection

  @override
  void onInit() {
    super.onInit();
    fetchSavedCardCount();
    fetchCards();
  }

  Future<void> fetchCards() async {
    cardCollection.snapshots().listen((snapshot) {
      cards.value = snapshot.docs;
    });
  }

  Future<void> fetchSavedCardCount() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('cards')
          .get();
      savedCardCount.value = querySnapshot.docs.length;
    } catch (e) {
      print("Error fetching card count: $e");
    }
  }

  Future<void> addCard(context) async {
    try {
      addCardIsLoading(true);
      var store = cardCollection.doc();
      String pin = await encryptSecret(cardPinController.text);
      print(store);
      await store.set({
        'c_user': currentUser!.uid,
        'c_bank_name': bankNameController.text,
        'c_type': cardTypeController.text,
        'c_holders_name': cardHoldersNameController.text,
        'c_number': cardNumberController.text,
        'c_cvv': cvvController.text,
        'c_favourites': false,
        'c_pin': pin,
        'c_expiry_month': expiryMonthController.text,
        'c_expiry_year': expiryYearController.text,
        'c_created_At': FieldValue.serverTimestamp(),
        'c_updated_at': FieldValue.serverTimestamp(),
      });

      // Clear the input fields
      bankNameController.clear();
      cardHoldersNameController.clear();
      cardNumberController.clear();
      cardPinController.clear();
      cvvController.clear();
      cardTypeController.clear();
      expiryMonthController.clear();
      expiryYearController.clear();

      addCardIsLoading(false);
      savedCardCount.value += 1;
    } catch (e) {
      print("Error adding card: $e");
    }
  }

  Future<void> updateCard(String? docId) async {
    try {
      if (docId == null || docId.isEmpty) {
        print("Error: Received empty docId");
        return;
      }

      print("Updating card with ID: $docId"); // Debugging line

      updateCardIsLoading(true);
      var store = cardCollection.doc(docId);
      String pin = await encryptSecret(cardPinEdittingController.text);

      await store.set({
        'c_bank_name': bankNameEdittingController.text,
        'c_type': cardTypeEdittingController.text,
        'c_holders_name': cardHoldersNameEdittingController.text,
        'c_number': cardNumberEdittingController.text,
        'c_cvv': cvvEdittingController.text,
        'c_pin': pin,
        'c_expiry_month': expiryMonthEdittingController.text,
        'c_expiry_year': expiryYearEdittingController.text,
        'c_updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("Card updated successfully!");
    } catch (e) {
      print("Error updating card: $e");
    } finally {
      updateCardIsLoading(false);
    }
  }

  Future<void> deleteCard(String docId) async {
    try {
      await cardCollection.doc(docId).delete();
      // Update card count
      savedCardCount.value -= 1;
    } catch (e) {
      print("Error deleting card: $e");
    }
  }

  Future<String> encryptSecret(String password) async {
    try {
      print("1");
      const storage = FlutterSecureStorage();
      print("object");
      var mainKeyValue = await storage.read(key: mainKey);
      print("2");
      var ivStr = await storage.read(key: ivKey);
      print("3");
      encrypt.Key key = encrypt.Key.fromBase16(mainKeyValue!.substring(0, 64));
      final iv = encrypt.IV.fromBase16(ivStr!);

      encrypt.Encrypter encrypter =
          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
      encrypt.Encrypted encrypted = encrypter.encrypt(password, iv: iv);

      return encrypted.base16;
    } catch (e) {
      print("Error encrypting secret: $e");
      rethrow;
    }
  }

  Future<String> decryptSecret(String password) async {
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
      print("Error decrypting secret: $e");
      rethrow;
    }
  }

  Future<void> checkIfFavourite(Map<String, dynamic> data) async {
    try {
      isFav(data['c_favourites'] ?? false);
    } catch (e) {
      print("Error checking favourite status: $e");
    }
  }

  Future<void> addToFavourite(context, String docId) async {
    try {
      await cardCollection.doc(docId).set({
        'c_favourites': true,
      }, SetOptions(merge: true));
      isFav(true);
    } catch (e) {
      print("Error adding to favourites: $e");
    }
  }

  Future<void> removeFromFavourite(context, String docId) async {
    try {
      await cardCollection.doc(docId).set({
        'c_favourites': false,
      }, SetOptions(merge: true));
      isFav(false);
    } catch (e) {
      print("Error removing from favourites: $e");
    }
  }
}
