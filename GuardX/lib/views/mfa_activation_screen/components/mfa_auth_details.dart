import 'package:get/get.dart';

import 'package:guardx/consts/index.dart';
import 'package:guardx/utils/helper/helper.dart';
import 'package:guardx/views/mfa_activation_screen/components/action_buttons.dart';
import 'package:guardx/views/mfa_activation_screen/components/mfa_advantages_space.dart';
import 'package:guardx/views/mfa_activation_screen/why_enable_mfa_screen.dart';

Widget mfaAuthDetails() {
  logger.d("Enable Mfa Screen ");
  return Container(
    constraints: BoxConstraints(
      maxWidth: 250,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mfaAdvantagesSpace(),
        5.heightBox,
        learnMoreAboutMfa.tr.text
            .size(10)
            .color(mainColor)
            .fontFamily(medium)
            .make()
            .onTap(() => Get.to(() => WhyEnableMfaScreen())),
        7.heightBox,
        weStrictlyRecommendEnablingMFA.tr.text
            .size(10)
            .color(whiteColor)
            .fontFamily(semibold)
            .underline
            .make(),
        30.heightBox,
        actionButtons(),
      ],
    ),
  );
}
