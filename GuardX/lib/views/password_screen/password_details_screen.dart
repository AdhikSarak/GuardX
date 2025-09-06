import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/password_controller.dart';
import 'package:guardx/utils/widgets/custom_button%20copy.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart';
import 'package:guardx/utils/widgets/loading_indicator.dart';
import 'package:guardx/views/password_screen/componenets/tag_space.dart';

class PasswordDetailsScreen extends StatelessWidget {
  final dynamic data;
  final String pass;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   PasswordDetailsScreen({super.key, this.data, required this.pass});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PasswordController());
    controller.pWebsiteLinkEditingController =
        TextEditingController(text: data['p_website_link']);
    controller.pEmailUsernameEditingController =
        TextEditingController(text: data['p_email_username']);
    controller.pPasswordEditingController = TextEditingController(text: pass);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          AppImages.imgUser,
                        ),
                      ),
                      20.widthBox,
                      Expanded(
                        child: "${data['p_website_name']}"
                            .text
                            .bold
                            .size(20)
                            .make(),
                      ),
                      10.widthBox,
                      Obx(
                        () => Icon(
                          Icons.favorite,
                          size: 24,
                          color: controller.isFav.value ? redColor : lightGrey,
                        ).onTap(() {
                          if (controller.isFav.value) {
                            controller.removeFromFavourite(context, data.id);
                          } else {
                            controller.addToFavourite(context, data.id);
                          }
                        }),
                      )
                    ],
                  ),
                  20.heightBox,
                  Obx(
                    () => customTextfield(
                      textEditingController:
                          controller.pEmailUsernameEditingController,
                      heading: emailOrUsername.tr,
                      textLabel: "${data['p_email_username']}",
                      suffixIcon1: IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: data['p_email_username']));
                            VxToast.show(context,
                                msg: emailCopiedToClipboard.tr);
                          },
                          icon: const Icon(Icons.copy_rounded)),
                      readOnly: controller.readOnlyPasswordDetails.value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email or username cannot be empty";
                        }

                        // Check if the input is an email
                        if (value.contains('@')) {
                          // Regex for a valid email address
                          if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value.trim())) {
                            return "Invalid email address";
                          }
                        } else {
                          // Check if the input is a valid username
                          if (!RegExp(r'^[a-zA-Z0-9_]+$')
                              .hasMatch(value.trim())) {
                            return "Username can only contain letters, numbers, and underscores";
                          }

                          // Optional: Minimum length for username
                          if (value.trim().length < 3) {
                            return "Username must be at least 3 characters long";
                          }
                        }

                        return null;
                      },
                    ),
                  ),
                  15.heightBox,
                  Obx(
                    () => PasswordCustomTextField(
                      textEditingController:
                          controller.pPasswordEditingController,
                      heading: password.tr,
                      textLabel: pass,
                      suffixIcon2: IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: pass));
                            VxToast.show(context,
                                msg: passwordCopiedToClipboard.tr);
                          },
                          icon: const Icon(Icons.copy_rounded)),
                      readOnly: controller.readOnlyPasswordDetails.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }

                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }

                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Password must contain at least one number';
                        }

                        if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                          return 'Password must contain at least one letter';
                        }

                        return null;
                      },
                    ),
                  ),
                  15.heightBox,
                  Obx(
                    () => customTextfield(
                      textEditingController:
                          controller.pWebsiteLinkEditingController,
                      heading: website.tr,
                      textLabel: "${data['p_website_link']}",
                      suffixIcon2: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.language)),
                      readOnly: controller.readOnlyPasswordDetails.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Website URL cannot be empty";
                        } else if (!RegExp(
                                r'^(https?:\/\/)?([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,}(\/[^\s]*)?$')
                            .hasMatch(value)) {
                          return "Please enter a valid website URL";
                        }
                        return null;
                      },
                    ),
                  ),
                  20.heightBox,
                  tags.tr.text.bold.make(),
                  10.heightBox,
                  tagSpace(data['p_tags']),
                  30.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => controller.updatePasswordIsLoading.value
                              ? Center(child: loadingIndicator())
                              : controller.readOnlyPasswordDetails.value
                                  ? newCustomButton(
                                      editItem, whiteColor, mainColor, () {
                                      controller.readOnlyPasswordDetails(false);
                                    }, false)
                                  : newCustomButton(save, whiteColor, mainColor,
                                      () {
                                      controller.updatePasswordIsLoading(true);
                                      controller.updatePassword(data.id);
                                      controller.readOnlyPasswordDetails(true);
                                      VxToast.show(context,
                                          msg: passwordUpdatedSuccessfully.tr);
                                    }, false),
                        ),
                      ),
                      10.widthBox,
                      const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                        size: 24,
                      )
                          .box
                          .color(mainColor)
                          .customRounded(BorderRadius.circular(8))
                          .size(45, 45)
                          .make()
                          .onTap(() {
                        controller.deletePassword(data.id);
                        Get.back();
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
