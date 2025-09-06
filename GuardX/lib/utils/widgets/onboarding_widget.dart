import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/colors.dart';
import 'package:guardx/controllers/onboarding_controller.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';

class OnboardingWidget extends StatelessWidget {
  final OnboardingPage page;
  final bool isLastPage;
  final bool showPrevious;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const OnboardingWidget({
    Key? key,
    required this.page,
    required this.isLastPage,
    required this.onSkip,
    required this.onNext,
    this.onPrevious,
    this.showPrevious = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      color: AppColor.blackColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (page.showSkip)
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: onSkip,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BigText(
                      text: 'Skip',
                      size: 15,
                      color: AppColor.whiteColor,
                    ),
                    Icon(
                      size: 15,
                      Icons.arrow_forward_ios,
                      color: AppColor.whiteColor,
                    ),
                  ],
                ),
              ),
            ),
          const Spacer(),
          // Container(
          //   width: 200,
          //   height: 200,
          //   decoration: BoxDecoration(
          //     gradient: const RadialGradient(
          //       center: Alignment(0, -0.1),
          //       colors: [
          //         // Color(0xFF0C16DC),
          //         Colors.red,
          //         Colors.red,
          //         // Color(0xFF0C16DC),
          //       ],
          //       radius:
          //           0.9, // Adjust this value to control the spread of the gradient
          //     ),
          //     image: DecorationImage(
          //       image: AssetImage(page.image),
          //       fit: BoxFit.cover, // Ensure the image covers the container
          //     ),
          //   ),
          // ),
          CircleAvatar(
            radius: 120,
            backgroundColor: Color(0xFF1332FE).withOpacity(0.2),
            child: Image.asset(page.image),
          ),

          const SizedBox(height: 20),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: AppColor.whiteColor),
          ),
          const Spacer(),
          // Dot Indicator
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3, // Number of pages
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Get.find<OnboardingController>().currentPage.value ==
                                  index
                              ? Colors.white
                              : Colors.grey,
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              page.showPrevious
                  ? OutlinedButton(
                      onPressed: onPrevious,
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(), // Circular shape
                        side: const BorderSide(
                            color: Colors.white), // White border
                        backgroundColor: Colors.black, // Black background
                        padding: const EdgeInsets.only(
                            left: 10, top: 12, bottom: 12),
                        alignment: Alignment.center,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.btnColor, // Icon color
                      ),
                    )
                  : Container(),
              isLastPage
                  ? Expanded(
                      child: CustomElevatedButton(
                        onPressed: onNext,
                        text: "Get Started",
                        borderColor: AppColor.btnColor,
                        backgroundColor: AppColor.btnColor,
                        forgroundColor: AppColor.mainColor,
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(10),
                          backgroundColor: AppColor.btnColor,
                          disabledBackgroundColor: AppColor.btnColor),
                      onPressed: onNext,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BigText(
                            text: " Next",
                            size: 18,
                            color: AppColor.whiteColor,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: AppColor.whiteColor,
                          )
                        ],
                      )),
            ],
          )
        ],
      ),
    );
  }
}
