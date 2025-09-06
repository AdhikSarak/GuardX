import 'package:guardx/consts/index.dart';
import 'package:guardx/utils/widgets/custom_button%20copy.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart';
import 'package:guardx/utils/widgets/dropdown_button_formfiled.dart';

class DocumentDetailsScreen extends StatelessWidget {
  const DocumentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.credit_card_rounded),
                  Expanded(
                      child: cardDetail.text
                          .size(20)
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .make()),
                  Icon(Icons.favorite_outline)
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.heightBox,
                      Row(
                        children: [
                          customTextfield(heading: bankName, textLabel: "SBI"),
                          10.widthBox,
                          DropdownButtonFormfiled(
                            value: "Credit Card",
                            items: debitCreditCardList,
                            heading: card,
                            textLabel: "",
                            isPass: false,
                            readOnly: false,
                          ),
                        ],
                      ),
                      20.heightBox,
                      customTextfield(
                          heading: cardHoldersName,
                          textLabel: "Mr. Adhik Sarak"),
                      20.heightBox,
                      customTextfield(
                          heading: cardNumber, textLabel: "12345678901234"),
                      20.heightBox,
                      Row(
                        children: [
                          customTextfield(heading: cardPin, textLabel: "1234"),
                          10.widthBox,
                          PasswordCustomTextField(
                              heading: cvv, textLabel: cvv, readOnly: false)
                        ],
                      ),
                      20.heightBox,
                      Row(
                        children: [
                          DropdownButtonFormfiled(
                            value: monthList[0].value!,
                            items: monthList,
                            heading: expiryMonth,
                            textLabel: month,
                            isPass: false,
                            readOnly: false,
                          ),
                          10.widthBox,
                          DropdownButtonFormfiled(
                            value: yearList[0].value!,
                            items: yearList,
                            heading: "",
                            textLabel: year,
                            isPass: false,
                            readOnly: false,
                          ),
                        ],
                      ),
                      40.heightBox,
                      newCustomButton(
                          savePassword, whiteColor, mainColor, () {}, false)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
