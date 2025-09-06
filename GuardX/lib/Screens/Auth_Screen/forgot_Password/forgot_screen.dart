import 'package:get/get.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/auth_controller.dart';
import 'package:guardx/utils/helper/utils_constant.dart';
import 'package:guardx/utils/widgets/custom_button.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/controllers/resetpassword_controller.dart';
import 'package:guardx/widgets/small_text.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;
  final AuthController _authController = Get.put(AuthController());
  final PasswordResetController passwordResetController =
      Get.put(PasswordResetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const BigText(
          text: AppText.title,
          color: AppColor.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Guardx.text.size(32).color(blueColor).bold.make(),
              Center(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    constraints: BoxConstraints(maxWidth: 400, maxHeight: 350),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        forgotPassword.text.color(whiteColor).size(24).make(),
                        10.heightBox,
                        enterYourEmailToReceiveToken.text.make(),
                        20.heightBox,
                        customTextfield(
                            textEditingController: _emailController,
                            heading: email,
                            textLabel: "adhik@crewhub.in"),
                        20.heightBox,
                        customButton(submit, whiteColor, blueColor, () async {
                          if (Utils.isEmailValid
                              .hasMatch(_emailController.text)) {
                            bool emailExists = await _authController
                                .checkIfEmailExists(_emailController.text);
                            if (emailExists) {
                              await passwordResetController
                                  .sendPasswordResetEmail(
                                      _emailController.text);
                              GetSnackBar(
                                backgroundColor: Colors.green,
                                titleText: SmallText(
                                  text:
                                      "Forgot password link is sent $emailExists",
                                ),
                              );
                              // Get.to(() => ChangeEmailScreen(
                              //     email: _emailController.text));
                            } else {
                              Get.snackbar(
                                  AppText.error, AppText.emailNotRegistered,
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          } else {
                            Get.snackbar(AppText.error, AppText.enterValidEmail,
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.shield_outlined,
                color: whiteColor,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
