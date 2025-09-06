import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/Screens/Auth_Screen/login/login_widget.dart';
import 'package:guardx/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(body: Obx(() {
      if (authController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: screenWidth <= 400 ? double.infinity : 500,
            child: const LoginWidget(),
          ),
        );
      }
    }));
  }
}
