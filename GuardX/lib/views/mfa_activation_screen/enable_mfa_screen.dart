import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/views/mfa_activation_screen/components/mfa_auth_details.dart';
 
class EnableMFAScreen extends StatelessWidget {
  const EnableMFAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
        ),
        body: Container(
          height: context.screenHeight,
          width: context.screenWidth,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.5),
              colors: [
                gradientColor,
                bgColor,
              ],
              radius: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(image: AssetImage(enableMFAImg)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    enableMultiFactorAuthentication.tr.text
                        .size(20)
                        .color(whiteColor)
                        .center
                        .fontFamily(bold)
                        .make(),
                    15.heightBox,
                    mfaAuthDetails(),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

  