import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/controllers/card_controller.dart';
import 'package:guardx/controllers/home_controller.dart';
import 'package:guardx/controllers/password_controller.dart';
import 'package:guardx/controllers/user_controller.dart';
import 'package:guardx/routes/route_helper.dart';
import 'package:guardx/widgets/small_text.dart';

void showLogoutDialog(BuildContext context) {
  final userController =
      Get.find<UserController>(); // Get the UserController instance

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: SmallText(
          text: "Logout Confirmation",
          size: 18.0,
          color: Colors.red,
        ),
        content: SmallText(
          text: "Are You Sure to Logout?",
          size: 16.0,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: SmallText(
              text: "Cancel",
              size: 14,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Perform logout
              await FirebaseAuth.instance.signOut();
              userController.clearUserData(); // Clear user data

              // Clear secure storage
              // await clearSecureStorage();

              // Delete GetX controllers
              Get.delete<CardController>(force: true);
              Get.delete<PasswordController>(force: true);
              Get.delete<HomeController>(force: true);

              // Navigate to login screen
              Get.offAllNamed(RouteHelper.logIn);
            },
            child: SmallText(
              text: "Logout",
              size: 14,
            ),
          ),
        ],
      );
    },
  );
}
