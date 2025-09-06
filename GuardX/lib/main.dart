import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';  
import 'package:guardx/consts/index.dart'; 
import 'package:guardx/firebase_options.dart';
import 'package:guardx/languages/languages.dart';
import 'package:guardx/routes/route_helper.dart'; 
import 'package:guardx/views/theme_data/themes.dart';

void configureFirebaseAuth() async {
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL); // Persist login session
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureFirebaseAuth();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppText.title,
      translations: Languages(),
      debugShowCheckedModeBanner: false,
      //locale: Get.deviceLocale,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: Themes().darkTheme,
      initialBinding: BindingsBuilder(() {}),

      // home:PasswordGenerate(),
      initialRoute: RouteHelper.splash,
      getPages: RouteHelper.routes,
    );
  }
}
