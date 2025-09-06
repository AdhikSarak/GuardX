import 'package:get/get.dart';
import 'package:guardx/Screens/Auth_Screen/login/login_screen.dart'; 
import 'package:guardx/Screens/Auth_Screen/Signup_Screeen/signup_screen.dart';  
import 'package:guardx/consts/index.dart'; 
import 'package:guardx/widgets/custom_elevated_button.dart';
import 'package:guardx/widgets/small_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: const Color(0xFF05070E),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        AppImages.icon,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: AppText.welcomeTitle,
                        style: TextStyle(
                            color: AppColor.whiteColor, fontSize: 24,)),
                    TextSpan(
                        text: "X",
                        style:
                            TextStyle(fontSize: 30, color: AppColor.whiteColor))
                  ])),
                  const SizedBox(height: 0),
                  SmallText(
                    text: AppText.welcomeMessage,
                    align: TextAlign.center,
                    size: 16,
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                      width: double.maxFinite,
                      child: CustomElevatedButton(
                        backgroundColor: AppColor.mainColor,
                        borderColor: AppColor.mainColor,
                        borderRadius: 11,
                        text: AppText.login,
                        onPressed: () => Get.to(() => const LoginScreen()),
                      )),
                  const SizedBox(height: 12),
                  SizedBox(
                      width: double.maxFinite,
                      child: CustomElevatedButton(
                        text: AppText.signup,
                        backgroundColor: Colors.black,
                        borderRadius: 11,
                        borderColor: AppColor.whiteColor,
                        forgroundColor: AppColor.whiteColor,
                        textColor: AppColor.whiteColor,
                        onPressed: () => Get.to(() => const SignUpScreen()),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
