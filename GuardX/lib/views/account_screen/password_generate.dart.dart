import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/password_generate_controller.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';

class PasswordGenerate extends StatelessWidget {
  const PasswordGenerate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordGenerateController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.blackColor,
        title: const BigText(
          text: "Generate Password",
          color: AppColor.whiteColor,
        ),
      ),
      backgroundColor: AppColor.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightBox,
                const BigText(
                  text: "Generated Password",
                  size: 16,
                  color: AppColor.whiteColor,
                ),
                8.heightBox,
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => TextField(
                          style: TextStyle(
                            color: AppColor.whiteColor,
                          ),
                          controller: TextEditingController(
                            text: controller.generatedPassword.value,
                          ),
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: controller.generatedPassword.value.isEmpty
                                ? "Pass12@"
                                : "",
                            hintStyle:
                                const TextStyle(color: AppColor.whiteColor),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColor.whiteColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.copy,
                                  color: AppColor.whiteColor),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                      text: controller.generatedPassword.value),
                                );
                                // Optionally, you can show a SnackBar or toast message to indicate the text has been copied
                                Get.snackbar(
                                  "Copied",
                                  "Password copied to clipboard",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.black54,
                                  colorText: Colors.white,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xFF606060)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.refresh,
                            color: AppColor.whiteColor),
                        onPressed: () => controller.generatePassword(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Icon(Icons.password, color: AppColor.whiteColor),
                    const SizedBox(width: 10),
                    const BigText(
                      text: 'Password length',
                      color: AppColor.whiteColor,
                      size: 20,
                    ),
                    const Spacer(),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xFF606060)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: AppColor.whiteColor),
                              onPressed: () => controller
                                  .decreasePasswordLength() // controller.decrementPasswordLength(),
                              ),
                          Obx(() => Text(
                                controller.passwordLength.toString(),
                                style: const TextStyle(
                                    color: AppColor.whiteColor, fontSize: 20),
                              )),
                          IconButton(
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: AppColor.whiteColor),
                              onPressed: () => controller
                                  .increasePasswordLength() // controller.incrementPasswordLength(),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                customGenerate(
                  'Uppercase Letters',
                  Icons.abc,
                  Obx(() => Switch(
                        value: controller.includeUpperCase.value,
                        onChanged: controller.includeUpperCase.call,
                        inactiveTrackColor: Colors.white.withOpacity(0.7),
                        inactiveThumbColor: Colors.white,
                      )),
                ),
                customGenerate(
                  'Lowercase Letters',
                  Icons.abc_outlined,
                  Obx(() => Switch(
                        value: controller.includeLowerCase.value,
                        onChanged: controller.includeLowerCase.call,
                        inactiveTrackColor: Colors.white.withOpacity(0.7),
                        inactiveThumbColor: Colors.white,
                      )),
                ),
                customGenerate(
                  'Numbers',
                  Icons.numbers,
                  Obx(() => Switch(
                        value: controller.includeNumbers.value,
                        onChanged: controller.toggleNumbers,
                        inactiveTrackColor: Colors.white.withOpacity(0.7),
                        inactiveThumbColor: Colors.white,
                      )),
                ),
                customGenerate(
                  'Symbols',
                  Icons.percent,
                  Obx(() => Switch(
                        value: controller.includeSymbols.value,
                        onChanged: controller.toggleSymbols,
                        inactiveTrackColor: Colors.white.withOpacity(0.7),
                        inactiveThumbColor: Colors.white,
                      )),
                ),
                const SizedBox(height: 30),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Expanded(
                //       child: SizedBox(
                //         height: 1,
                //         child: DecoratedBox(
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     BigText(
                //       text: "Or",
                //       color: AppColor.whiteColor,
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Expanded(
                //       child: SizedBox(
                //         height: 1,
                //         child: DecoratedBox(
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 20),
                // const TextField(
                //   style: TextStyle(color: AppColor.whiteColor),
                //   decoration: InputDecoration(
                //     fillColor: Colors.white24,
                //     filled: true,
                //     hintText: "Enter your name",
                //     hintStyle: TextStyle(color: AppColor.whiteColor),
                //   ),
                // ),
                const SizedBox(height: 40),
                Center(
                  child: CustomElevatedButton(
                    text: "Generate Now",
                    backgroundColor: AppColor.mainColor,
                    borderColor: AppColor.mainColor,
                    onPressed: () => controller.generatePassword(),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customGenerate(String fieldText, IconData icon, Widget switchBtn) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: AppColor.whiteColor),
        const SizedBox(width: 10),
        Expanded(
          child: BigText(
            text: fieldText,
            color: AppColor.whiteColor,
            size: 20,
          ),
        ),
        switchBtn,
      ],
    ),
  );
}
