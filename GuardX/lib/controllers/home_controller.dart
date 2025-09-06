import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardx/consts/firebase_helper.dart';
import 'package:guardx/controllers/card_controller.dart';
import 'package:guardx/controllers/password_controller.dart';

class HomeController extends GetxController {
  var navBarIndex = 0.obs;
  var searchController = TextEditingController();

  // State variables for Passwords and Cards
  var passwordListIndex = 0.obs;
  var savedPasswords = <QueryDocumentSnapshot>[].obs;
  var savedCards = <QueryDocumentSnapshot>[].obs;

  // Inject Card & Password Controllers
  final CardController cardController = Get.put(CardController());
  final PasswordController passwordController = Get.put(PasswordController());

  // Firestore references
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    fetchPasswords(); // Start listening for password changes
    fetchCards(); // Start listening for card changes
  }

  // Fetch passwords in real-time from Firestore
  void fetchPasswords() {
    _firestore.collection('users').doc(userId).collection('passwords').snapshots().listen((snapshot) {
      savedPasswords.value = snapshot.docs;
    });
  }

  // Fetch cards in real-time from Firestore
  void fetchCards() {
    _firestore.collection('users').doc(userId).collection('cards').snapshots().listen((snapshot) {
      savedCards.value = snapshot.docs;
    });
  }

  // Refresh method to manually fetch data (optional)
  void refreshData() {
    fetchPasswords();
    fetchCards();
  }
}
