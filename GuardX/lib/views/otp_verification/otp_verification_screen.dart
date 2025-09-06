import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/utils/widgets/custom_button%20copy.dart';
import 'package:pinput/pinput.dart'; 

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isDisabled = true;

  // final CountdownController controller = new CountdownController();
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
          decoration: BoxDecoration(
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
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(image: AssetImage(otpImg)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    otpVerification.tr.text
                        .size(20)
                        .color(whiteColor)
                        .center
                        .fontFamily(bold)
                        .make(),
                    13.heightBox,
                    "$enterTheAuthenticationCodeSentTo+91 9503975655"
                        .tr
                        .text
                        .size(12)
                        .color(lightGrey)
                        .center
                        .fontFamily(medium)
                        .make(),
                    "+91 9503975655"
                        .tr
                        .text
                        .size(12)
                        .color(lightGrey)
                        .center
                        .fontFamily(medium)
                        .make(),
                    30.heightBox,
                    Pinput(
                      length: 6,
                      showCursor: true,
                      onChanged: (value) {},
                      onCompleted: (value) {
                        setState(() {
                          isDisabled = false;
                        });
                      },
                      autofocus: true,
                      defaultPinTheme: PinTheme(
                        width: 35,
                        height: 35,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: blackColor,
                        ),
                        decoration: BoxDecoration(
                          color: textfieldGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    25.heightBox,
                    //CountdownTimer(controller: controller),
                    // Countdown(
                    //   //controller: controller,
                    //   seconds: 120,
                    //   build: (BuildContext context, double time) =>
                    //       formattedTime(time.toInt())
                    //           .tr
                    //           .text
                    //           .size(9)
                    //           .color(whiteColor)
                    //           .center
                    //           .fontFamily(medium)
                    //           .make(),
                    //   interval: Duration(milliseconds: 1000),
                    //   onFinished: () {
                    //     print('Timer is done!');
                    //   },
                    // ),
                    /*
                    formattedTime(time.toInt())
                        .tr
                        .text
                        .size(9)
                        .color(whiteColor)
                        .center
                        .fontFamily(medium)
                        .make(),*/
                    didntYouReceiveTheOtp.tr.richText
                        .withTextSpanChildren([
                          resendOtp.textSpan
                              .size(12)
                              .color(mainColor)
                              .fontFamily(regular)
                              .make()
                        ])
                        .size(12)
                        .color(whiteColor)
                        .fontFamily(regular)
                        .make(),
                    36.heightBox,
                    SizedBox(
                      width: 272,
                      child: newCustomButton(verify, whiteColor, mainColor,
                          isDisabled ? null : () => {}, false),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  String formattedTime(int time) // --> time in form of seconds
  {
    final int sec = time % 60;
    final int min = (time / 60).floor();
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }
}
