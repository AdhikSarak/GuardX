import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/account_controller.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart';
import 'package:guardx/utils/widgets/loading_indicator.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    void changePassword() {
      if (!controller.areDetailsFilled()) {
        VxToast.show(context, msg: pleaseFillAllTheDetails);
      } else if (!controller.validateNewPass()) {
        VxToast.show(context, msg: pleaseEnterAStrongPassword);
      } else {
        controller.isChangePasswordLoading(true);
        controller.changePassword(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blackColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
          color: AppColor.whiteColor,
        ),
        title: const BigText(
          text: 'Change Password',
          color: AppColor.whiteColor,
        ),
      ),
      backgroundColor: AppColor.blackColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Old Password Field
              customTextfield(
                textEditingController: controller.oldPasswordController,
                heading: AppText.enterOldPassword,
                textLabel: AppText.enterOldPassword,
                readOnly: false,
              ),
              const SizedBox(height: 20),

              // New Password Field
              customTextfield(
                textEditingController: controller.newPasswordController,
                heading: AppText.enterNewPassword,
                textLabel: AppText.enterNewPassword,
                readOnly: false,
              ),
              const SizedBox(height: 20),

              // Confirm New Password Field
              customTextfield(
                textEditingController: controller.confirmPasswordController,
                heading: AppText.enterConfirmPassword,
                textLabel: AppText.repeatePassword,
                readOnly: false,
              ),
              const SizedBox(height: 50),

              // Save Button with Loading Indicator
              Obx(
                () => controller.isChangePasswordLoading.value
                    ? loadingIndicator()
                    : SizedBox(
                        width: context.width,
                        child: CustomElevatedButton(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 30),
                          text: AppText.save,
                          textColor: AppColor.whiteColor,
                          backgroundColor: AppColor.mainColor,
                          borderColor: AppColor.mainColor,
                          onPressed: changePassword,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
