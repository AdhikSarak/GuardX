import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/utils/helper/helper.dart';
import 'package:guardx/views/home_screen/home.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';
import 'package:pinput/pinput.dart'; 

class MfaVerificationScreen extends StatefulWidget {
  final String verificationId;
  final bool isTwoFactorEnabled = false;
  const MfaVerificationScreen({super.key, required this.verificationId});

  @override
  State<MfaVerificationScreen> createState() => _MfaVerificationScreenState();
}

class _MfaVerificationScreenState extends State<MfaVerificationScreen> {
  var isDisabled = true;
  String? smsCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
        ),
        body: Container(
          height: context.screenHeight,
          width: context.screenWidth,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.5),
              colors: [
                gradientColor,
                bgColor,
              ],
              radius: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(image: AssetImage(enableMFAImg)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    mfaVerification.tr.text
                        .size(20)
                        .color(whiteColor)
                        .center
                        .fontFamily(bold)
                        .make(),
                    13.heightBox,
                    enterTheAuthenticationCodeSentTo.tr.text
                        .size(12)
                        .color(lightGrey)
                        .center
                        .fontFamily(medium)
                        .make(),
                    "+91 9503975655"
                        .tr
                        .text
                        .size(12)
                        .color(lightGrey)
                        .center
                        .fontFamily(medium)
                        .make(),
                    30.heightBox,
                    Pinput(
                      length: 6,
                      showCursor: true,
                      onChanged: (value) {
                        smsCode = value;
                      },
                      onCompleted: (value) {
                        smsCode = value;
                      },
                      autofocus: true,
                      defaultPinTheme: PinTheme(
                        width: 35,
                        height: 35,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: whiteColor,
                        ),
                        decoration: BoxDecoration(
                          color: textfieldGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    25.heightBox,
                    // Countdown(
                    //   //controller: controller,
                    //   seconds: 120,
                    //   build: (BuildContext context, double time) =>
                    //       formattedTime(time.toInt())
                    //           .tr
                    //           .text
                    //           .size(9)
                    //           .color(whiteColor)
                    //           .center
                    //           .fontFamily(medium)
                    //           .make(),
                    //   interval: const Duration(milliseconds: 1000),
                    //   onFinished: () {
                    //     print('Timer is done!');
                    //   },
                    // ),
                    didntYouReceiveTheOtp.tr.richText
                        .withTextSpanChildren([
                          resendOtp.textSpan
                              .size(12)
                              .color(mainColor)
                              .fontFamily(regular)
                              .make()
                        ])
                        .size(12)
                        .color(whiteColor)
                        .fontFamily(regular)
                        .make(),
                    36.heightBox,
                    SizedBox(
                      width: 272,
                      child: CustomElevatedButton(
                        backgroundColor: AppColor.mainColor,
                        onPressed: () async {
                          if (smsCode == null || smsCode!.isEmpty) {
                            Get.snackbar('', AppText.entersmscode);
                            return;
                          }

                          final PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: smsCode!,
                          );
                          try {
                            await FirebaseAuth.instance.currentUser?.multiFactor
                                .enroll(
                              PhoneMultiFactorGenerator.getAssertion(
                                credential,
                              ),
                            );

                            // Update Firestore to set isTwoFactorEnabled to true
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .update({
                                'isTwoFactorEnabled': true,
                                'lastTwoFactorVerifiedAt': Timestamp.now(),
                              });
                            }
                            logger.i("User Authenticated");

                            Get.to(() => const Home());
                            logger.d("moving to home page");
                          } on FirebaseAuthException catch (e) {
                            Get.snackbar(AppText.mfaError,
                                '${AppText.anErrorOccurred} ${e.message}');
                          }
                        },
                        text: AppText.verify,
                      ),
                      /*newCustomButton(
                          verify,
                          whiteColor,
                          mainColor,
                          isDisabled ? null : () => {logger.d("message")
                          },
                          false),*/
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  String formattedTime(int time) // --> time in form of seconds
  {
    final int sec = time % 60;
    final int min = (time / 60).floor();
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }
}
