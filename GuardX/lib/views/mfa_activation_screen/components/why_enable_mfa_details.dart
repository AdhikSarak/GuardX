import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/views/mfa_activation_screen/components/mfa_advantages_space.dart';
import 'package:guardx/views/mfa_activation_screen/components/mfa_detail_text.dart';

Widget whyEnableMFADetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      whyEnableMFA.tr.text
                        .size(14)
                        .color(whiteColor)
                        .fontFamily(semibold)
                        .makeCentered(),
      12.heightBox,
      mfaDetailText(),      
      36.heightBox,
      mfaAdvantagesSpace(),
      29.heightBox,
      weStrictlyRecommendEnablingMFA.tr.text.size(12).color(whiteColor).fontFamily(semibold).underline.makeCentered(),
      45.heightBox,
    ],
  );
}
