import 'package:get/get.dart';
import 'package:guardx/consts/index.dart'; 
import 'package:guardx/controllers/language_controller.dart';
import 'package:guardx/controllers/theme_controller.dart';
import 'package:guardx/views/account_screen/change_password_screen.dart';
import 'package:guardx/views/account_screen/components/select_language.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Get.put(ThemeController());
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              leading: settingsScreenIconList[index],
              title: settingsScreenList[index].tr.text.make(),
              subtitle: switch (index) {
                0 => settingsScreenSubtitle[index]?.tr.text.make(),
                1 => Obx(
                    () => Get.put(LanguageController()).returnTrue.value
                        ? languageCodes[Get.locale.toString()]!.tr.text.make()
                        : language.tr.text.make(),
                  ),
                2 => Obx(
                    () => Get.put(ThemeController()).isDarkTheme.value
                        ? darkMode.tr.text.make()
                        : lightMode.tr.text.make(),
                  ),
                3 => settingsScreenSubtitle[index]?.tr.text.make(),
                4 => settingsScreenSubtitle[index]?.tr.text.make(),
                _ => settingsScreenList[index].tr.text.make(),
              },
              onTap: () {
                switch (index) {
                  case 0:
                    // Get.to(() => GuardxImportanceScreen());
                    break;
                  case 1:
                    _displaySelectLanguageBottomSheet(context);
                    break;
                  case 2:
                    if (themeController.isDarkTheme.value == false) {
                      themeController.toDarkTheme();
                    } else {
                      themeController.toLightTheme();
                    }
                    break;
                  case 3:
                    Get.to(() => ChangePasswordScreen());
                    break;
                  case 4:
                    // Get.to(() => GuardxImportanceScreen());
                    break;
                  default:
                    break;
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: lightGrey,
            );
          },
          itemCount: settingsScreenList.length),
    );
  }

  Future _displaySelectLanguageBottomSheet(BuildContext context) {
    return selectLanguage(context);
  }
}
