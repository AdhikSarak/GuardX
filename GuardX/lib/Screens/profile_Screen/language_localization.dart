 
import 'package:get/get.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/language_controllers111.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';
import 'package:guardx/widgets/language_option.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});
  final LanguageControllers111 languageController =
      Get.put(LanguageControllers111());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blackColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
          color: AppColor.whiteColor,
        ),
        title: const BigText(
          text: "Language",
          color: AppColor.whiteColor,
        ),
      ),
      backgroundColor: AppColor.blackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            10.heightBox,
            Obx(() => LanguageOption(
                  language: "English",
                  languageLabel: "(English)",
                  isSelected:
                      languageController.selectedLanguage.value == 'English',
                  onTap: () => languageController.changeLanguage('English'),
                )),
            8.heightBox,
            Obx(() => LanguageOption(
                  language: 'Hindi',
                  languageLabel: '(Hindi)',
                  isSelected:
                      languageController.selectedLanguage.value == 'Hindi',
                  onTap: () => languageController.changeLanguage('Hindi'),
                )),
            8.heightBox,
            Obx(() => LanguageOption(
                  language: 'Marathi',
                  languageLabel: '(Marathi)',
                  isSelected:
                      languageController.selectedLanguage.value == 'Marathi',
                  onTap: () => languageController.changeLanguage('Marathi'),
                )),
            8.heightBox,
            Obx(() => LanguageOption(
                  language: 'Gujarati',
                  languageLabel: '(Gujarati)',
                  isSelected:
                      languageController.selectedLanguage.value == 'Gujarati',
                  onTap: () => languageController.changeLanguage('Gujarati'),
                )),
            30.heightBox,
            SizedBox(
              width: context.width,
              child: CustomElevatedButton(
                text: AppText.save,
                backgroundColor: AppColor.mainColor,
                borderColor: AppColor.mainColor,
                onPressed: () {
                  languageController.saveLanguage();
                  // You can show a success message or navigate back
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
