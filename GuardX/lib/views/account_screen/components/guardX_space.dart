import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';

Widget GuardXSpace() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        kawach.tr.text.size(20).bold.color(blueColor).make(),
        "1.0.0".text.make(),
      ],
    ),
  );
}
