import 'package:guardx/consts/index.dart';

Widget tagButton(String label) {
  return label.text
      .color(whiteColor)
      .make()
      .box
      .color(cardGrey)
      .customRounded(BorderRadius.circular(8))
      .padding(const EdgeInsets.symmetric(horizontal: 15, vertical: 10))
      .make();
}
