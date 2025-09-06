import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/controllers/onboarding_controller.dart';
import 'package:guardx/utils/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.pages.length,
              itemBuilder: (context, index) {
                final page = controller.pages[index];
                return OnboardingWidget(
                  page: page,
                  isLastPage: index == controller.pages.length - 1,
                  onSkip: controller.onSkip,
                  onNext: controller.onNext,
                  onPrevious: controller.onPrevious,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
