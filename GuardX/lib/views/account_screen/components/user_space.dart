import 'package:get/get.dart'; 
import 'package:guardx/consts/index.dart';

Widget userSpace() {
  return Column(
    children: [
      CircleAvatar(
        backgroundImage: AssetImage(AppImages.imgUser),
        radius: 30,
      ),
      10.heightBox,
      currentUser!.email!.substring(0, currentUser!.email!.indexOf('@')).capitalizeFirst!.text.size(20).bold.make(),
      const Divider(color: lightGrey, thickness: 2,)
    ],
  );
}
