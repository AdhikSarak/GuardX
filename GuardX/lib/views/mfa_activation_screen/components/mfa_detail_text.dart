import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';

Widget mfaDetailText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      whyEnableMFAText.tr.text
          .size(10)
          .color(semiLightGrey)
          .fontFamily(regular)
          .make(),
      20.heightBox,
      somethingYouKnowie.tr.richText
          .withTextSpanChildren(
              [password.textSpan.size(12).color(whiteColor).make()])
          .size(12)
          .color(semiLightGrey)
          .fontFamily(regular)
          .make(),
      somethingYouHaveie.tr.richText
          .withTextSpanChildren(
              [uniqueCodeOnPhone.textSpan.size(12).color(whiteColor).make()])
          .size(12)
          .color(semiLightGrey)
          .fontFamily(regular)
          .make(),
    ],
  );
}
