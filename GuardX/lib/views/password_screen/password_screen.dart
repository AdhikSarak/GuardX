
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart'; 
import 'package:guardx/utils/widgets/search_bar.dart';
import 'package:guardx/utils/widgets/password_list.dart'; 
import 'package:guardx/controllers/password_controller.dart';

class PasswordScreen extends StatelessWidget {
   PasswordScreen({super.key});
 // Instance of the PasswordController
  @override
  Widget build(BuildContext context) {
    final PasswordController passwordController = Get.put(PasswordController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: Column(
            children: [
              searchBar(search.tr, context),
              10.heightBox,
               Expanded(
                child: Obx(() {
                  if (passwordController.passwords.isEmpty) {
                   
                    return Center(
                      child: nothingAddedYet.tr.text.make(),
                    );
                  } else {
                    var data = passwordController.passwords;
                    return passwordList(context, data);
                  }
                }),)
            ],
          ),
        ),
      ),
    );
  }
}
