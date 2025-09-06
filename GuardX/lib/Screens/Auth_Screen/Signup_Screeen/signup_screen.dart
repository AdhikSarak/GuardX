import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/colors.dart';
import 'package:guardx/consts/strings.dart';
import 'package:guardx/routes/route_helper.dart';
import 'package:guardx/utils/helper/helper.dart';
import 'package:guardx/utils/helper/utils_constant.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';
import 'package:guardx/widgets/custom_textformfield.dart';
import 'package:guardx/widgets/small_text.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:guardx/controllers/signup_controller.dart'; 
import '../../../utils/widgets/loading_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _isEmailValid = false;
  bool _isPasswordVisible = false;
  bool _isEmailError = false;
  bool _isPasswordError = false;

  void _signUp() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _repeatPasswordController.text.trim();

    setState(() {
      _isEmailError = !Utils.isEmailValid.hasMatch(email);
      _isPasswordError = password != confirmPassword;
    });

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        _isEmailError ||
        _isPasswordError) {}

    try {
      await signUpController.signUp(email, password);
    } catch (error) {
      Get.snackbar(AppText.error, error.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return signUpController.isLoading.value
            ? LoadingWidget(
                message: "Signing In ${_emailController.text.trim()}")
            : SingleChildScrollView(
                child: Container(
                  height: context.height,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.mainColor,
                        AppColor.blackColor,
                        AppColor.blackColor,
                        AppColor.blackColor,
                        AppColor.blackColor,
                        AppColor.blackColor,
                        AppColor.blackColor,
                        AppColor.blackColor,
                        AppColor.blackColor,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BigText(
                        text: AppText.signup,
                        weight: FontWeight.bold,
                        color: AppColor.whiteColor,
                        size: 24,
                      ),
                      8.heightBox,
                      SmallText(
                        text: AppText.createAccount,
                        color: AppColor.whiteColor,
                        size: 18,
                      ),
                      28.heightBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BigText(
                            text: AppText.email,
                            color: AppColor.whiteColor,
                            size: 18,
                          ),
                          5.heightBox,
                          CustomTextFormField(
                            controller: _emailController,
                            hintText: AppText.email,
                            suffixIcon: _isEmailValid ? Icons.check : null,
                            suffixIconColor: Colors.green,
                            onChanged: (value) {
                              setState(
                                () {
                                  _isEmailValid =
                                      Utils.isEmailValid.hasMatch(value);
                                  _isEmailError = !_isEmailValid;
                                },
                              );
                            },
                          ),
                          if (_isEmailError)
                            Column(
                              children: [
                                4.heightBox,
                                const Text(
                                  AppText.emailformatError,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                        ],
                      ),
                      10.heightBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BigText(
                            text: AppText.password,
                            color: AppColor.whiteColor,
                            size: 18,
                          ),
                          5.heightBox,
                          CustomTextFormField(
                            controller: _passwordController,
                            hintText: AppText.enterYourPassword,
                            obscureText: !_isPasswordVisible,
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            suffixIcon: _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          10.heightBox,
                          const BigText(
                            text: AppText.repeatePassword,
                            color: AppColor.whiteColor,
                            size: 18,
                          ),
                          5.heightBox,
                          CustomTextFormField(
                            controller: _repeatPasswordController,
                            hintText: AppText.enterYourPassword,
                            obscureText: !_isPasswordVisible,
                            onPressed: () {
                              logger.d("verify password");
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            suffixIcon: _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          if (_isPasswordError)
                            Column(
                              children: [
                                4.heightBox,
                                Obx(() =>
                                    signUpController.errorMessage.isNotEmpty
                                        ? Text(
                                            signUpController.errorMessage.value,
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : Container()),
                                const Text(
                                  AppText.passwordMismatchError,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                        ],
                      ),
                      24.heightBox,
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          text: AppText.signup,
                          backgroundColor: AppColor.mainColor,
                          borderColor: AppColor.mainColor,
                          onPressed: () {
                            _signUp();
                          },
                        ),
                      ),
                      20.heightBox,
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white, // Line color
                              ),
                            ),
                          ),
                          BigText(
                            text: "Or",     
                            color: AppColor.whiteColor,
                            weight: FontWeight.w400,
                            size: 14,
                          ),
                          SizedBox(
                            width: 120,
                            height: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white, // Line color
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      RichText(
                        text: TextSpan(
                          text: AppText.alreadyHaveAccount,
                          style: const TextStyle(
                            color: AppColor.whiteColor,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => (
                                      (Get.toNamed(RouteHelper.logIn),),
                                    ),
                              text: AppText.login,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
