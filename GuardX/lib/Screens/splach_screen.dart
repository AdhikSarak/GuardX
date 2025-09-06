import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    // Animation initialization
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    // Delayed navigation with session check
    Timer(
      const Duration(seconds: 4),
      _navigateBasedOnSession,
    );
  }

  // Function to navigate based on login status
   void _navigateBasedOnSession() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      debugPrint("User found: ${currentUser.email}");
      Get.offNamed(RouteHelper.home);
    } else {
      debugPrint("No user found. Navigating to onboarding screen.");
      Get.offNamed(RouteHelper.onboarding);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05070E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                AppImages.icon,
                width: 300,
              ),
            ),
          ),
          Center(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: AppText.welcomeTitle,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: "X",
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
