import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/utils/helper/helper.dart';
import 'package:guardx/views/home_screen/home.dart';
import 'package:guardx/views/mfa_verification_screen/mfa_verification_screen.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final User? user;
  final MultiFactorResolver? resolver;
  const PhoneVerificationScreen({super.key, this.user, this.resolver});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController smsCodeController = TextEditingController();

  late final TextEditingController _phoneNumberController;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int? _resendToken;
  // Variable to store the resend token
  String? _countryCode;
  // Store the selected country code
  @override
  void initState() {
    logger.i("initState");
    _phoneNumberController = TextEditingController();
    super.initState();
    _checkAndSendOTP();
  }

  @override
  void dispose() {
    logger.i("Phone Screen Deleted..");
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _checkAndSendOTP() async {
    logger.i("Otp Send to registered Number..");

    if (widget.user != null) {
      final userDoc =
          await _firestore.collection('users').doc(widget.user!.uid).get();
      if (userDoc.exists) {
        final phoneNumber = userDoc.data()?['phoneNumber'];
        if (phoneNumber != null) {
          _sendOtp(phoneNumber);
        } else {
          logger.e("No phone number found for user.");
          Get.snackbar(AppText.error, AppText.noPhoneNumberFound,
              backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        }
      } else {
        logger.e("User document does not exist.");
        Get.snackbar(AppText.error, AppText.userDocNotFound,
            backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
      }
    } else {
      sendOtpResolver();
    }
  }

  Future<void> _sendOtp(String phoneNumber) async {
    sendOtpNumber(phoneNumber);
  }

  Future<void> _mfaverification() async {
    final auth = FirebaseAuth.instance;

    try {
      MultiFactorSession session =
          await auth.currentUser!.multiFactor.getSession();

      String phoneNumber = _phoneNumberController.text.trim();
      if (_countryCode != null) {
        phoneNumber = '$_countryCode$phoneNumber';
      }
      logger.i("Sending OTP to $phoneNumber");

      await auth.verifyPhoneNumber(
        multiFactorSession: session,
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Auto-retrieval or instant verification succeeded.
          logger.i("Phone number verified automatically: $credential");
        },
        verificationFailed: (FirebaseAuthException e) {
          logger.e("Verification failed: ${e.message}");
          Get.snackbar(
              AppText.error, '${AppText.phoneverificationfailed} ${e.message}',
              backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        },
        codeSent: (String verificationID, int? resendToken) async {
          logger.d('Verification code sent to $phoneNumber');

          // Store the resend token
          _resendToken = resendToken;

          // Store phone number in Firestore
          await _firestore
              .collection('users')
              .doc(auth.currentUser?.uid)
              .update({
            'phoneNumber': phoneNumber,
            'lastTwoFactorVerifiedAt': Timestamp.now(),
            'isTwoFactorEnabled': true,
          });

          Get.to(MfaVerificationScreen(verificationId: verificationID));
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          logger.w(
              "Code auto-retrieval timeout for verification ID: $verificationID");
        },
        forceResendingToken: _resendToken,
        // recaptchaVerifier: recaptchaVerifier,
      );
    } catch (e) {
      logger.e('Error in phone verification: $e');
      Get.snackbar(
          AppText.error, '${AppText.phoneverificationfailed} ${e.toString()}',
          backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
              center: Alignment(0, -0.3),
              colors: [
                gradientColor,
                bgColor,
              ],
              radius: 0.6,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(image: AssetImage(phoneVerificationImg)),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      phoneVerification.tr.text
                          .size(20)
                          .color(whiteColor)
                          .center
                          .fontFamily(bold)
                          .make(),
                      15.heightBox,
                      weWillSendYouOneTimePasswordToYourMobileNumber.tr.text
                          .size(10)
                          .color(whiteColor)
                          .center
                          .fontFamily(regular)
                          .make(),
                      50.heightBox,
                      enterMobileNumber.tr.text
                          .size(10)
                          .color(whiteColor)
                          .center
                          .fontFamily(regular)
                          .make(),
                      10.heightBox,
                      Container(
                        width: 272,
                        child: Column(
                          children: [
                            IntlPhoneField(
                              initialCountryCode: 'IN',
                              showDropdownIcon: false,
                              controller: _phoneNumberController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(top: 11),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: mainColor,
                                )),
                              ),
                              onChanged: (phone) {
                                _countryCode = phone.countryCode != "+91"
                                    ? "+91"
                                    : phone.countryCode;
                              },
                            ),
                            45.heightBox,
                            CustomElevatedButton(
                              text: AppText.submit,
                              backgroundColor: AppColor.mainColor,
                              onPressed: () {
                                if (_phoneNumberController.text
                                    .trim()
                                    .isEmpty) {
                                  Get.snackbar(AppText.requiredf,
                                      AppText.enterValidphone);
                                } else {
                                  _mfaverification();
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void sendOtpResolver() async {
    logger.i("Sending OTP resolving");

    try {
      logger.i('Sending OTP to $_phoneNumberController');

      final firstHint = widget.resolver?.hints.first;
      if (firstHint is! PhoneMultiFactorInfo) {
        return;
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        multiFactorSession: widget.resolver?.session,
        multiFactorInfo: firstHint,
        verificationCompleted: (_) {},
        verificationFailed: (_) {},
        codeSent: (String verificationID, int? resendToken) {
          logger.i('OTP sent successfully'); // Logging

          Get.to(MfaVerificationScreen(verificationId: verificationID));
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      logger.i('Error sending OTP: $e'); // Logging
      Get.snackbar(AppText.error, '${AppText.failedTosendOTP} ${e.toString()}',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void sendOtpNumber(String phoneNumber) async {
    logger.i("Sending OTP normally");
    final auth = FirebaseAuth.instance;

    try {
      print('Sending OTP to $phoneNumber'); // Logging
      MultiFactorSession session =
          await auth.currentUser!.multiFactor.getSession();

      await auth.verifyPhoneNumber(
        multiFactorSession: session,
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          logger.d('Verification completed'); // Logging
          Get.offAll(() => const Home());
        },
        verificationFailed: (FirebaseAuthException e) {
          logger.d('Verification failed: ${e.message}'); // Logging
          Get.snackbar(AppText.error, '${AppText.failedTosendOTP} ${e.message}',
              backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (String verificationID, int? resendToken) {
          Get.to(MfaVerificationScreen(verificationId: verificationID));
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      logger.d('Error sending OTP: $e'); // Logging
      Get.snackbar(AppText.error, '${AppText.failedTosendOTP} ${e.toString()}',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
