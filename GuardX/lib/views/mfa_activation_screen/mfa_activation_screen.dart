import 'package:get/get.dart';
import 'package:guardx/Screens/Auth_Screen/Mfa_Screens/mfa_screen.dart'; 
import 'package:guardx/consts/index.dart';
import 'package:guardx/utils/widgets/custom_button.dart';
import 'package:guardx/views/home_screen/home.dart';

class MFAPromptScreen extends StatelessWidget {
  const MFAPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    const Icon(
                      Icons.lock,
                      color: blueColor,
                      size: 60,
                    ),
                    30.heightBox,
                    "Why enable MFA?"
                        .text
                        .size(24)
                        .bold
                        .color(blueColor)
                        .make(),
                    "Here's why!!".text.size(24).bold.color(blueColor).make(),
                    SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            20.heightBox,
                            "\u2022 Enhanced Account Security"
                                .text
                                .size(16)
                                .make(),
                            "\u2022 Prevents Unauthorised Access"
                                .text
                                .size(16)
                                .make(),
                            "\u2022 Protects Your Sensitive Information"
                                .text
                                .size(16)
                                .make(),
                            "\u2022 Easy to set up, hard to hack!!"
                                .text
                                .size(16)
                                .make()
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      AppImages.logo,
                      fit: BoxFit.fitHeight,
                      height: 110,
                      width: 200,
                    ),
                    "We strictly recommend enabling MFA"
                        .text
                        .size(16)
                        .bold
                        .color(blueColor)
                        .makeCentered(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child:
                                  customButton(skip, blueColor, whiteColor, () {
                            Get.offAll(() => const Home());
                          })),
                          20.widthBox,
                          Expanded(
                              child: customButton(
                                  enableMFANow, whiteColor, blueColor, () {
                            Get.to(() => const MultiFactorScreen());
                          })),
                        ],
                      ),
                    ),
                    mFAAddingNote.text.color(fontGrey).make()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
