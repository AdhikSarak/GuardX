import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/card_controller.dart';
import 'package:guardx/utils/widgets/custom_button%20copy.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart';
import 'package:guardx/utils/widgets/dropdown_button_formfiled.dart';
import 'package:guardx/utils/widgets/loading_indicator.dart';
import 'package:guardx/views/add_password/components/type_selector_space.dart';

class AddCardScreen extends StatelessWidget {
  AddCardScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CardController());
    return Scaffold(
        appBar: AppBar(
          title: saveACard.tr.text
              .size(20)
              .color(whiteColor)
              .fontFamily(semibold)
              .make(),
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          width: context.screenWidth,
          height: context.screenHeight,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardTypeSpace(),
                  10.heightBox,
                  Row(
                    children: [
                      customTextfield(
                          textEditingController: controller.bankNameController,
                          heading: bankName,
                          textLabel: "SBI"),
                      10.widthBox,
                      DropdownButtonFormfiled(
                        textEditingController: controller.cardTypeController,
                        //value: "Credit Card",
                        items: debitCreditCardList,
                        heading: card,
                        textLabel: "Card Type",
                        isPass: false,
                        readOnly: false,
                      ),
                    ],
                  ),
                  20.heightBox,
                  customTextfield(
                    textEditingController: controller.cardHoldersNameController,
                    heading: cardHoldersName,
                    textLabel: "vinay kumar",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Cardholder's name cannot be empty";
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
                        return "Cardholder's name must contain only letters and spaces";
                      }
                      if (value.trim().length < 2) {
                        return "Cardholder's name must be at least 2 characters long";
                      }
                      return null;
                    },
                  ),
                  20.heightBox,
                  customTextfield(
                    textEditingController: controller.cardNumberController,
                    heading: cardNumber,
                    textLabel: "1234******1234",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return "Card number cannot be empty";
                      if (!RegExp(r'^[0-9]+$').hasMatch(value))
                        return "Card number must contain only digits";
                      if (value.length < 13 || value.length > 19) {
                        return "Card number must be between 13 and 19 digits";
                      }
                      return null;
                    },
                  ),
                  20.heightBox,
                  Row(
                    children: [
                      customTextfield(
                        textEditingController: controller.cardPinController,
                        heading: cardPin,
                        textLabel: "XXXX",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "PIN cannot be empty";
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "PIN must contain only digits";
                          }
                          if (value.length != 3 && value.length != 4) {
                            return "PIN must be 3 or 4 digits";
                          }
                          return null;
                        },
                      ),
                      10.widthBox,
                      PasswordCustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "CVV cannot be empty";
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return "CVV must contain only digits";
                            }
                            if (value.length != 3 && value.length != 4) {
                              return "CVV must be 3 or 4 digits";
                            }
                            return null;
                          },
                          textEditingController: controller.cvvController,
                          heading: cvv,
                          textLabel: cvv,
                          readOnly: false)
                    ],
                  ),
                  20.heightBox,
                  Row(
                    children: [
                      DropdownButtonFormfiled(
                        textEditingController: controller.expiryMonthController,
                        //value: monthList[0].value!,
                        items: monthList,
                        heading: expiryMonth,
                        textLabel: month,
                        isPass: false,
                        readOnly: false,
                      ),
                      10.widthBox,
                      DropdownButtonFormfiled(
                        textEditingController: controller.expiryYearController,
                        //value: yearList[0].value!,
                        items: yearList,
                        heading: "",
                        textLabel: year,
                        isPass: false,
                        readOnly: false,
                      ),
                    ],
                  ),
                  40.heightBox,
                  Obx(
                    () => controller.addCardIsLoading.value
                        ? loadingIndicator()
                        : newCustomButton(saveCard, whiteColor, mainColor, () {
                            if (_formKey.currentState!.validate()) {
                              controller.addCardIsLoading(true);
                              controller.addCard(context);
                              Get.back();
                            }
                          }, false),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
