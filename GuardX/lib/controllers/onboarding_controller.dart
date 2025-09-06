import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/images.dart';
import 'package:guardx/routes/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var hasSeenOnboarding = false.obs;
  var currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    hasSeenOnboarding.value = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding.value) {
      // Navigate to Signup & Login screen if onboarding has already been shown
      Get.offNamed('/login');
    } else {
      // Navigate to Onboarding screen
      Get.offNamed('/onboarding');
    }
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    hasSeenOnboarding.value = true;

    Get.offNamed('/login');
  }

  List<OnboardingPage> pages = [
    OnboardingPage(
      showSkip: true,
      showPrevious: false,
      image: AppImages.onboard1,
      description:
          "You can forget a password, know it but can't recall, or it's just on the tip of your tongue. It’s there, we know for sure.",
    ),
    OnboardingPage(
      showSkip: false,
      showPrevious: true,
      image: AppImages.onboard2,
      description:
          "Imagine a guardian that protects all your passwords, remembers them for you, and ensures they are encrypted, all while providing a hassle-free experience for you!",
    ),
    OnboardingPage(
      showSkip: false,
      showPrevious: false,
      image: AppImages.onboard3,
      description:
          "Escape the password maze with our app. GuardX consolidates all your codes into one safe, secure vault, ensuring your identity is protected. Trust in GuardX for your security needs!",
    ),
  ];

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void onSkip() {
    Get.offNamed(RouteHelper.welcome);
  }

  void onNext() {
    if (currentPage.value == pages.length - 1) {
      Get.offNamed(RouteHelper.welcome);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void onPrevious() {
    if (currentPage.value == pages.length - 1) {
      Get.offNamed(RouteHelper.welcome);
    } else {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingPage {
  final bool showSkip;
  final bool showPrevious;
  final String image;
  final String description;

  OnboardingPage({
    required this.showSkip,
    required this.showPrevious,
    required this.image,
    required this.description,
  });
}
