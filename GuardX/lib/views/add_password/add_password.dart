import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/password_controller.dart';
import 'package:guardx/utils/widgets/custom_button%20copy.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart';
import 'package:guardx/utils/widgets/loading_indicator.dart';
import 'package:guardx/views/add_password/components/type_selector_space.dart';

class AddPasswordScreen extends StatelessWidget {
  AddPasswordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PasswordController());
    void addPassword() {
      controller.addPasswordIsLoading(true);
      controller.addPassword(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: saveAPassword.tr.text
              .size(20)
              .color(whiteColor)
              .fontFamily(semibold)
              .make(),
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          width: context.screenWidth,
          height: context.screenHeight,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  accountTypeSpace(),
                  30.heightBox,
                  customTextfield(
                    textEditingController: controller.pWebsiteNameController,
                    heading: websiteName,
                    textLabel: crewhub,
                    textInputType: TextInputType.url,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Website Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                  20.heightBox,
                  customTextfield(
                    textEditingController: controller.pWebsiteLinkController,
                    heading: websiteLink,
                    textLabel: crewhubLink,
                    textInputType: TextInputType.url,
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
                  20.heightBox,
                  customTextfield(
                    textEditingController: controller.pEmailUsernameController,
                    heading: emailusername,
                    textLabel: crewhubEmail,
                    textInputType: TextInputType.emailAddress,
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
                  20.heightBox,
                  PasswordCustomTextField(
                    textEditingController: controller.pPasswordController,
                    heading: password,
                    textLabel: crewhubPassword,
                    readOnly: false,
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
                  70.heightBox,
                  Obx(
                    () => controller.addPasswordIsLoading.value
                        ? loadingIndicator()
                        : newCustomButton(submit.tr, whiteColor, blueColor, () {
                            if (_formKey.currentState!.validate()) {
                              addPassword();
                              Get.back();
                            }
                          }, false),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
