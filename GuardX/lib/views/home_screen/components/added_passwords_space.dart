 // addedPasswordsSpace.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/home_controller.dart';
import 'package:guardx/services/firebase_services.dart';
import 'package:guardx/utils/widgets/loading_indicator.dart';
import 'package:guardx/utils/widgets/password_list.dart'; 
import 'package:flutter/material.dart'; // Import the Flutter material

Widget addedPasswordsSpace(BuildContext context) {
  final HomeController controller = Get.find<HomeController>(); 

  return Obx(
    () => StreamBuilder<QuerySnapshot>(
      stream: getStream(controller.passwordListIndex.value, currentUser!.uid), // Pass the uid to getStream
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData) {
          return Center(child: loadingIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(child: nothingAddedYet.tr.text.make());
        }

        // Use snapshot data directly
        var data = snapshot.data!.docs;
        return passwordList(context, data);
      },
    ),
  );
}

Stream<QuerySnapshot> getStream(int index, String uid) {
  switch (index) {
    case 0:
      return FirebaseServices.getRecentlyAddedPasswords(uid);
    case 1:
      return FirebaseServices.getRecentlyUpdatedPasswords(uid);
    case 2:
      return FirebaseServices.getFavouritePasswords(uid);
    default:
      return FirebaseServices.getRecentlyAddedPasswords(uid); //Default
  }
}

