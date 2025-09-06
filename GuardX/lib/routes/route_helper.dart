import 'package:get/get.dart';
import 'package:guardx/Screens/Auth_Screen/forgot_Password/forgot_screen.dart';
import 'package:guardx/Screens/Auth_Screen/login/login_screen.dart';
import 'package:guardx/Screens/Auth_Screen/Signup_Screeen/signup_screen.dart';
import 'package:guardx/Screens/onboarding_screen/onboarding.dart';
import 'package:guardx/Screens/splach_screen.dart';
import 'package:guardx/Screens/welcome_Screen.dart'; 
import 'package:guardx/views/home_screen/home.dart';
import 'package:guardx/views/home_screen/home_screen.dart';
import 'package:guardx/views/add_password/add_password.dart';
import 'package:guardx/views/add_password/add_card.dart';

class RouteHelper {
  // Define Route variables
  static const String splash = '/';
  static const String onboarding = '/onboard-screen';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String mainhomeScreen = '/homeScreen';
  static const String signUp = '/signUp';
  static const String logIn = '/logIn';
  static const String forgotPassword = '/forgot-password';
  static const String newPassword = '/new-password';
  static const String otpVerification = '/otpVerification';
  static const String addPasswordScreen = '/addPasswordScreen';
  static const String addCardScreen = '/addCardScreen';

  static String getHome() => home;
  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: welcome, page: () => const WelcomeScreen()),
    GetPage(name: home, page: () => Home()),
    GetPage(name: mainhomeScreen, page: () => HomeScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: logIn, page: () => const LoginScreen()),
    GetPage(name: forgotPassword, page: () => const ForgotScreen()),
    GetPage(name: addPasswordScreen, page: () => AddPasswordScreen()),
    GetPage(name: addCardScreen, page: () => AddCardScreen()),
  ];
}
