import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/colors.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/password_controller.dart';

import 'package:guardx/controllers/theme_controller.dart';
import 'package:guardx/utils/widgets/loading_indicator.dart';
import 'package:guardx/views/password_screen/password_details_screen.dart';


Widget actionButton(Icon icon, Widget textLabel) {
  return Column(
    children: [
      icon,
      textLabel,
    ],
  ); 

}

Widget actionSpace(data, context) {
  var controller = Get.put(PasswordController());
  var themeController = Get.put(ThemeController());
  return Obx(
    () => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Visibility(
            visible: controller.readOnlyPasswordDetails.value,
            child: actionButton(Icon(Icons.star, color: controller.isFav.value ? goldenColor : lightGrey,),
                    favourite.tr.text.make())
                .onTap(() {
              if (controller.isFav.value) {
                controller.removeFromFavourite(context, data.id);
              } else {
                controller.addToFavourite(context, data.id);
              }
              
            })),
        controller.updatePasswordIsLoading.value
            ? loadingIndicator()
            : actionButton(
                    controller.readOnlyPasswordDetails.value
                        ? Icon(Icons.edit_outlined)
                        : Icon(
                            Icons.done,
                            color: greenColor,
                          ),
                    controller.readOnlyPasswordDetails.value
                        ? edit.tr.text.make()
                        : done.tr.text.bold.color(greenColor).make())
                .onTap(() {
                if (controller.readOnlyPasswordDetails.value) {
                  controller.readOnlyPasswordDetails(false);
                } else {
                  controller.updatePasswordIsLoading(true);
                  controller.updatePassword(data.id);
                  controller.readOnlyPasswordDetails(true);
                  VxToast.show(context, msg: passwordUpdatedSuccessfully.tr);
                  //controller.updatePasswordIsLoading(false);
                }
              }),
        Visibility(
          visible: controller.readOnlyPasswordDetails.value,
          child: VxPopupMenu(
            clickType: VxClickType.singleClick,
            menuBuilder: () => Column(
              children: List.generate(
                  passwordDetailsOtherPopUpTitles.length,
                  (index) => Row(
                        children: [
                          passwordDetailsOtherPopUpIcons[index],
                          20.widthBox,
                          passwordDetailsOtherPopUpTitles[index].text.make(),
                        ],
                      ).onTap(() {
                        switch (index) {
                          case 0:
                            controller.deletePassword(data.id);
                            VxToast.show(context, msg: deletedSuccessfully.tr);
                            Get.back();
                        }
                      })),
            )
                .box
                .rounded
                .width(200)
                .padding(const EdgeInsets.all(20))
                .color(
                    themeController.isDarkTheme.value ? blackColor : whiteColor)
                .make(),
            child: actionButton(
                const Icon(Icons.more_vert), others.tr.text.make()),
          ),
        ),
      ],
    ),
  );
}
