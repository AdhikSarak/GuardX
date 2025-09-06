import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:guardx/Screens/notes/notes.dart';
import 'package:guardx/Screens/profile_Screen/profile.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/language_controller.dart';
import 'package:guardx/controllers/theme_controller.dart';
import 'package:guardx/views/account_screen/password_generate.dart.dart';
import 'package:guardx/views/home_screen/home_screen.dart'; 

final List<BottomNavigationBarItem> navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),

    // Image(image: AssetImage(homeIc)),
    label: home.tr,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.note_alt_outlined),
    // Image(image: AssetImage(notesIc)),
    label: notes.tr,
  ),
  /*
  BottomNavigationBarItem(
    icon: SizedBox(),
    label: "",
  ),*/
  BottomNavigationBarItem(
    icon: Icon(Icons.auto_fix_normal_outlined),
    // Image(image: AssetImage(generateIc)),
    label: generate.tr,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    //Image(image: AssetImage(profileIc)),
    label: profile.tr,
  ),
];

final List<Widget> navBarBody = [
  const HomeScreen(),
  Notes(),
  const PasswordGenerate(),
  ProfileScreen(),
];
 
var categoryImageList = [
  Icon(Icons.key_rounded),
  Icon(Icons.credit_card_rounded),
  // Icon(Icons.document_scanner_outlined),
];

var categoryList = [
  savedPasswords,
  savedCards,
  // savedDocuments,
];

var categorySubTitleList = [
  passwords,
  cards,
  // documents,
];

var sliderList = [
  attackHappensOnDailyBasisJustBeReadyWithUsToPreventIt.tr,
];

var sliderImageList = [
  handInhandImg,
];

var categoryColorList = [
  category1Color,
  category2Color,
  category3Color,
];
  

var accountTypeData = [
  {"name": "Google ", "image": AppImages.google},
  {"name": "Facebook ", "image": AppImages.facebook},
  {"name": "Instagram ", "image": AppImages.instagram},
];
var documentTypeList = [
  "PAN Card",
  "Aadhar Card",
  "ID Card",
  "Personal File",
  "College Doc",
];

var cardTypeList = [
  "HDFC Bank",
  "SBI Bank",
  "ICICI Bank",
];

var debitCreditCardList = [
  DropdownMenuItem(child: "Debit Card".tr.text.make(), value: "Debit Card".tr),
  DropdownMenuItem(
      child: "Credit Card".tr.text.make(), value: "Credit Card".tr),
  DropdownMenuItem(child: "Visa Card".tr.text.make(), value: "Visa Card".tr),
  DropdownMenuItem(child: "RuPay Card".tr.text.make(), value: "RuPay Card".tr),
  DropdownMenuItem(
      child: "Master Card".tr.text.make(), value: "Master Card".tr),
  DropdownMenuItem(
      child: "Maestro Card".tr.text.make(), value: "Maestro Card".tr),
];

int currentYear = DateTime.now().year;
//int startingYear = 2000;
List<DropdownMenuItem<String>> yearList = List.generate(
    (20),
    (index) => DropdownMenuItem(
          child: '${currentYear + index}'.tr.text.make(),
          value: '${currentYear + index}'.tr,
        ));
List<DropdownMenuItem<String>> monthList = List.generate(
    (12),
    (index) => DropdownMenuItem(
          child: '${1 + index}'.tr.text.make(),
          value: '${1 + index}'.tr,
        ));

var fileType = [
  fileDocument,
  image,
  voiceRecord,
];  

//dummy data
var sortByDropdownItems = [
  DropdownMenuItem(
    value: "0",
    child: "Recently Added".text.make(),
  ),
  DropdownMenuItem(value: "1", child: "Recently Editted".text.make()),
  DropdownMenuItem(value: "2", child: "Favourites".text.make()),
];

var languageList = [
  DropdownMenuItem(value: "en_US", child: "English".text.make()),
  DropdownMenuItem(value: "hi_IN", child: "हिंदी".text.make()),
  DropdownMenuItem(value: "mr_IN", child: "मराठी".text.make()),
];

var passwordDetailsOtherPopUpTitles = [
  delete.tr,
];

var passwordDetailsOtherPopUpIcons = [const Icon(Icons.delete_outline)];

var settingsScreenList = [
  kawachsImportance,
  language,
  theme,
  changePassword,
  help,
];

var settingsScreenIconList = [
  Icon(
    Icons.shield_outlined,
    color: blueColor,
  ),
  Icon(Icons.translate),
  Obx(
    () => Get.put(ThemeController()).isDarkTheme.value
        ? const Icon(Icons.dark_mode_outlined)
        : const Icon(
            Icons.wb_sunny_outlined,
            color: Colors.amber,
          ),
  ),
  Icon(Icons.key_outlined),
  Icon(Icons.help_outline),
];

var settingsScreenSubtitle = [
  knowTheIndispensabilityOfKawach,
  Get.put(LanguageController()).returnTrue.value
      ? languageCodes[Get.locale.toString()]!
      : language,
  Get.put(ThemeController()).isDarkTheme.value ? darkMode : lightMode,
  null,
  //"Change Your Password",
  helpCentreContactUsPrivacyPolicy,
];

var languageCodes = {
  "en_US": 'English (United States)',
  'hi_IN': 'हिंदी (भारत)',
  'mr_IN': 'मराठी (भारत)',
};

Future<(Uint8List?, String)> addFile() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(withData: true);
  print(result);
  PlatformFile file = result!.files.first;

  print(file.name);
  print(file.bytes);
  print(file.size);
  print(file.extension);
  return (file.bytes, file.name);
}
