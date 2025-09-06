import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/views/account_screen/change_password_screen.dart';

Widget userSpace() {
  // var controller = Get.put(ThemeController());
  // var langController = Get.put(LanguageController());
  return Row(
    children: [
      CircleAvatar(
        radius: 32,
        backgroundColor: whiteColor,
        child: CircleAvatar(
          backgroundImage: AssetImage(
            AppImages.imgUser,
          ),
          radius: 30,
        ).onTap(() {
          Get.to(() => ChangePasswordScreen());
        }),
      ),
      20.widthBox,
      Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //currentUser!.email!.substring(0, currentUser!.email!.indexOf('@')).capitalizeFirst!.text.semiBold.make(),
              getGreeting().tr.richText
                  // .withTextSpanChildren(
                  //     ["Adhik".textSpan.size(20).color(whiteColor).fontFamily(semibold).make()])
                  .size(20)
                  .color(whiteColor)
                  .fontFamily(semibold)
                  .make(),

              saveYourPasswordsEasilyAndSecurely.text
                  .size(10)
                  .color(lightGrey)
                  .fontFamily(regular)
                  .make(),
              //goodMorning.tr.text.make(),
            ]),
      ),
      IconButton(
        onPressed: () {
          Get.snackbar('', 'Under Progress...', colorText: Color(0xFF4421F3));
        },
        icon: const Icon(Icons.notifications_none_rounded),
      ),
    ],
  );
}

String getGreeting() {
  final DateTime now = DateTime.now();
  final int hour = now.hour;

  if (hour >= 5 && hour < 12) {
    return "Good Morning";
  } else if (hour >= 12 && hour < 17) {
    return "Good Afternoon";
  } else if (hour >= 17 && hour < 21) {
    return "Good Evening";
  } else {
    return "Good Night";
  }
}
