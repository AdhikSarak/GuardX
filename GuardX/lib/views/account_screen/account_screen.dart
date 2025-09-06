
import 'package:get/get.dart';
import 'package:guardx/Screens/Auth_Screen/login/login_screen.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/utils/widgets/custom_button.dart';
import 'package:guardx/views/account_screen/components/Guardx_space.dart';
import 'package:guardx/views/account_screen/components/settings_list.dart';
import 'package:guardx/views/account_screen/components/user_space.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                userSpace(),
                10.heightBox,
                const SettingsList(),
                const Divider(color: lightGrey, thickness: 2,),
                10.heightBox,                
                SizedBox(
                  width: 150,
                  child: customButton(logOut.tr, whiteColor, blueColor, () {
                    auth.signOut().then((_) async {
                      Get.to(() => const LoginScreen());
                    });
                  }),
                ),                    
                20.heightBox,
                GuardXSpace(),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
