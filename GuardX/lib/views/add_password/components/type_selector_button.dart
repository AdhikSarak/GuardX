
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/password_controller.dart';  
 
final PasswordController controller = Get.put(PasswordController());
Widget socialmediaAccountType({
  required List<Map<String, String>> socialMediaData,
}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: accountTypeData.map((data) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: accountTypeSelectorButton(
      textLabel: data["name"]!,
      imagePath: data["image"]!,
      onTap: () => controller.updateWebsiteName(data["name"]!),
    ),
  );
}).toList(),

    ),
  );
}

Widget accountTypeSelectorButton({
  required String textLabel,
  required String imagePath,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: () => onTap,
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            imagePath,
          ),
          radius: 10,
        ),
        const SizedBox(width: 8),
        Text(
            textLabel,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontFamily: 'Medium',
            ),
          ),
       
      ],
    )
        .box
        .customRounded(BorderRadius.circular(5))
        .height(28)
        .color(Colors.transparent)
        .padding(const EdgeInsets.all(5))
        .make(),
  );
}

Widget cardDocumentTypeSelectorButton(
  String textLabel,
) {
  return textLabel.text
      .size(13)
      .color(whiteColor)
      .fontFamily(medium)
      .make()
      .box
      .customRounded(BorderRadius.circular(5))
      .height(28)
      .color(textfieldGrey)
      .padding(const EdgeInsets.symmetric(horizontal: 10, vertical: 5))
      .make();
}
