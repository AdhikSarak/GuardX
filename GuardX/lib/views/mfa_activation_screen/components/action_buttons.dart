import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/utils/widgets/custom_button%20copy.dart';
import 'package:guardx/views/home_screen/home.dart'; 
import 'package:guardx/views/phone_verification/phone_verification_screen.dart'; 

Widget actionButtons() {
  return SizedBox(
    width: 272,
    child: Column(
      children: [
        newCustomButton(enableMFA, whiteColor, mainColor, () {
          Get.to(const PhoneVerificationScreen());
          // Get.to(const MfaVerificationScreen(verificationId: 'verificationId',));
        }, false),
        15.heightBox,
        newCustomButton(later, whiteColor, mainColor, () {
          Get.to(const Home());
        }, true),
      ],
    ),
  );
}
