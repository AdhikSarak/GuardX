import 'package:get/get.dart';
import 'package:guardx/consts/index.dart'; 
import 'package:guardx/controllers/home_controller.dart'; 
import 'package:guardx/views/card_screen/card_screen.dart';
import 'package:guardx/views/home_screen/components/category_item.dart';
import 'package:guardx/views/password_screen/password_screen.dart';

Widget categorySpace(BuildContext context) {
  var controller = Get.put(HomeController());
  // var passwordController = Get.put(PasswordController());

  return Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: categoryItem2(
              categoryImageList[1],
              categoryColorList[1],
              categoryList[1],
              categorySubTitleList[1],
              "${controller.savedCards.length}", // 🔹 Reactive card count
            ).onTap(() {
              Get.to(() => CardScreen());
            }),
          ),
          10.widthBox,
          Expanded(
            flex: 1,
            child: categoryItem2(
              categoryImageList[0],
              categoryColorList[0],
              categoryList[0],
              categorySubTitleList[0],
              "${controller.savedPasswords.length}", // 🔹 Reactive password count
            ).onTap(() {
              Get.to(() => PasswordScreen());
            }),
          ),
        ],
      ));
}
