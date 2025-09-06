import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/login_controller.dart';
import 'package:guardx/routes/route_helper.dart';
import 'package:guardx/utils/helper/helper.dart';
import 'package:guardx/utils/helper/utils_constant.dart';
import 'package:guardx/utils/widgets/loading_screen.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';
import 'package:guardx/widgets/custom_textformfield.dart';
import 'package:guardx/widgets/small_text.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Define a GlobalKey for the Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEmailValid = false;
  bool _isPasswordVisible = false;

  void _login() async {
    logger.d("Login function initiated");

    // Validate the form before proceeding
    if (!_formKey.currentState!.validate()) {
      logger.d("Form validation failed");
      return;
    }

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    try {
      await loginController.login(email, password);
    } catch (e) {
      Get.snackbar(
        AppText.error,
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
      logger.e("Login error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.i("Login screen build");

    return Scaffold(
      body: Obx(
        () {
          return loginController.isLoading.value
              ? LoadingWidget(
                  message: "Verifying ${_emailController.text.trim()}")
              : SingleChildScrollView(
                  // Added SingleChildScrollView to prevent overflow on smaller screens
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1216E5),
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const BigText(
                            text: AppText.login,
                            size: 24,
                            weight: FontWeight.w700,
                            color: AppColor.whiteColor,
                          ),
                          const SizedBox(height: 20),
                          SmallText(
                            text: AppText.loginToYourAccount,
                            color: AppColor.whiteColor,
                            size: 18,
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BigText(
                                text: AppText.email,
                                size: 18,
                                color: AppColor.whiteColor,
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                controller: _emailController,
                                hintText: AppText.enterYourEmail,
                                suffixIcon: _isEmailValid ? Icons.check : null,
                                suffixIconColor: Colors.green,
                                onChanged: (value) => setState(() {
                                  _isEmailValid =
                                      Utils.isEmailValid.hasMatch(value);
                                }),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppText.enterYourEmail;
                                  } else if (!Utils.isEmailValid
                                      .hasMatch(value)) {
                                    return AppText.enterValidEmail;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BigText(
                                text: AppText.password,
                                size: 18,
                                color: AppColor.whiteColor,
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                controller: _passwordController,
                                hintText: AppText.enterYourPassword,
                                obscureText: !_isPasswordVisible,
                                suffixIcon: _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppText.enterYourPassword;
                                  } else if (value.length < 6) {
                                    return AppText.passwordLengthError;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  logger.i("Forgot password screen navigation");
                                  (Get.toNamed(RouteHelper.forgotPassword),);
                                },
                                child: const Text(
                                  AppText.forgotPassword,
                                  style: TextStyle(color: AppColor.whiteColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: CustomElevatedButton(
                              backgroundColor: AppColor.mainColor,
                              borderColor: AppColor.mainColor,
                              text: AppText.login,
                              onPressed: () {
                                logger.d("Login button pressed");
                                _login();
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 1,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallText(
                                text: AppText.switchSignUptoLogin,
                                color: AppColor.whiteColor,
                                size: 14,
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  (Get.toNamed(RouteHelper.signUp),);
                                },
                                child: SmallText(
                                  text: AppText.signup,
                                  color: AppColor.mainColor,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
