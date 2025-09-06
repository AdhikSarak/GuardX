import 'package:flutter/services.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/password_controller.dart';
import 'package:guardx/views/password_screen/password_details_screen.dart';

Widget passwordList(context, data) {
  var controller = Get.put(PasswordController());
  return Column(
    children: List.generate(
      data.length,
      (index) => Card(
        color: cardGrey,
        margin: const EdgeInsets.all(7),
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              AppImages.imgUser,
            ),
          ),
          //title: recentUsedAccountList[index].text.size(14).color(whiteColor).fontFamily(semibold).make(),
          //subtitle: recentUsedTextList[index].text.size(10).color(whiteColor).fontFamily(medium).make(),
          
          title: "${data[index]['p_website_name']}".text.size(15).semiBold.make(),
          subtitle: "${data[index]['p_email_username']}".text.make(),
          
          trailing: IconButton(

            onPressed: () async {
              String clipboarData =
                  await controller.decryptSecret(data[index]['p_password']);
              Clipboard.setData(ClipboardData(text: clipboarData));
              VxToast.show(context, msg: passwordCopiedToClipboard.tr);
            },
            icon: Image(image: AssetImage(copyIc)),
            //icon: const Icon(Icons.copy),
          ),
        ),
      ).onTap(() async {
        String pass = await controller.decryptSecret(data[index]['p_password']);
        controller.checkIfFavourite(data[index]);
        print(data[index].id);

        Get.to(() => PasswordDetailsScreen(
              data: data[index],
              pass: pass,
            ));
      }),
    ),
  );
}
