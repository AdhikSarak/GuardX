import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';

Widget mfaAdvantagesSpace() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      advantagesOfEnablingMfaAuth.tr.text
          .size(12)
          .color(lightGrey)
          .fontFamily(medium)
          .make(),
      10.heightBox,
      reducesSecurityRisk.tr.text
          .size(10)
          .color(semiLightGrey)
          .fontFamily(regular)
          .make(),
      increasesTheDifficultyToHackGainAccess.tr.text
          .size(10)
          .color(semiLightGrey)
          .fontFamily(regular)
          .make(),
      reducesRisksFromCompromisedPasswords.tr.text
          .size(10)
          .color(semiLightGrey)
          .fontFamily(regular)
          .make(),
      providesRealTimeAlerts.tr.text
          .size(10)
          .color(semiLightGrey)
          .fontFamily(regular)
          .make(),
    ],
  );
}
