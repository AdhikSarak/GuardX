import 'package:get/get.dart';
import 'package:guardx/consts/index.dart'; 
import 'package:guardx/views/mfa_activation_screen/components/action_buttons.dart'; 
import 'package:guardx/views/mfa_activation_screen/components/why_enable_mfa_details.dart';

class WhyEnableMfaScreen extends StatelessWidget {
  const WhyEnableMfaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: bgColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //bottomOpacity: 1,
          elevation: 0,
          //forceMaterialTransparency: true,
        ),
        body: Container(
          height: context.screenHeight,
          width: context.screenWidth,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.8, -0.8),
              colors: [
                gradientColor,
                bgColor,
              ],
              radius: 0.7,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              //width: 307,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  enableMultiFactorAuthentication.tr.text
                      .size(20)
                      .color(whiteColor)
                      .center
                      .fontFamily(bold)
                      .make(),
                  45.heightBox,                    
                  whyEnableMFADetails(),
                  actionButtons(),                    
                ],
              ),
            ),
          ),
        ));
  }
}
