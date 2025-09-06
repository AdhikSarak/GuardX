import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:guardx/views/mfa_activation_screen/enable_mfa_screen.dart'; 
import '../../consts/index.dart';
import '../../utils/helper/helper.dart';
import '../../utils/widgets/custom_button.dart';

class EmailVerificationStatusScreen extends StatelessWidget {
  final String emailID;
  const EmailVerificationStatusScreen(this.emailID, {super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        // margin: EdgeInsets.symmetric(
        //     vertical: screenHeight * .08, horizontal: screenWidth * .05),
        // padding: EdgeInsets.only(
        //     left: screenWidth * .02,
        //     right: screenWidth * .02,
        //     top: screenHeight * .1),
        //width: screenWidth,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            colors: [
              gradientColor,
              bgColor,
            ],
            radius: 0.6,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.email,
                            color: blueColor,
                            size: 30,
                          ),
                          30.heightBox,
                          "Please Verify Email"
                              .text
                              .size(24)
                              .bold
                              .color(blueColor)
                              .makeCentered(),
                          10.heightBox,
                          "Email is sent to $emailID"
                              .text
                              .size(16)
                              .makeCentered(),
                          "Please check the inbox".text.size(16).makeCentered(),
                          "Click on the link in the mail"
                              .text
                              .size(16)
                              .makeCentered(),
                          "Its important to proceed!"
                              .text
                              .size(16)
                              .makeCentered(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customButton(
                        ifVerifiedPleaseProceed, whiteColor, blueColor, () {
                      checkEmailStatusAndProceed();
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkEmailStatusAndProceed() async {
    logger.i("Checking status of email");
    await FirebaseAuth.instance.currentUser?.reload();
    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      Get.snackbar(AppText.error, AppText.verifyEmail,
          snackPosition: SnackPosition.TOP);
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'lastLoginAt': FieldValue.serverTimestamp(),
    });
    Get.to(() => const EnableMFAScreen());
  }
}
