// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/card_controller.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart';
import 'package:guardx/utils/widgets/custom_button%20copy.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart';
import 'package:guardx/utils/widgets/loading_indicator.dart';

// ignore: must_be_immutable
class CardDetailsScreen extends StatelessWidget {
  dynamic data;
  String pin;
  final String cardId; // Add this

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CardDetailsScreen({
    super.key,
    required this.data,
    required this.pin,
    required this.cardId,
  });

  @override
  Widget build(BuildContext context) {
    final CardController controller = Get.put(CardController());
    controller.bankNameEdittingController =
        TextEditingController(text: data['c_bank_name']);
    controller.cardHoldersNameEdittingController =
        TextEditingController(text: data['c_holders_name']);
    controller.cardNumberEdittingController =
        TextEditingController(text: data['c_number']);
    controller.cardPinEdittingController = TextEditingController(text: pin);
    controller.cvvEdittingController =
        TextEditingController(text: data['c_cvv']);
    controller.cardTypeEdittingController =
        TextEditingController(text: data['c_type']);
    controller.expiryMonthEdittingController =
        TextEditingController(text: data['c_expiry_month']);
    controller.expiryYearEdittingController =
        TextEditingController(text: data['c_expiry_year']);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.credit_card),
                      20.widthBox,
                      Expanded(
                        child: cardDetail.text.bold.size(20).make(),
                      ),
                      10.widthBox,
                      Obx(
                        () => Icon(
                          Icons.favorite,
                          size: 24,
                          color: controller.isFav.value ? redColor : lightGrey,
                        ).onTap(() {
                          if (controller.isFav.value) {
                            controller.removeFromFavourite(context, cardId);
                          } else {
                            controller.addToFavourite(context, cardId);
                          }
                        }),
                      )
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      Obx(
                        () => customTextfield(
                          textEditingController:
                              controller.bankNameEdittingController,
                          heading: bankName.tr,
                          textLabel: "${data['c_bank_name']}",
                          readOnly: controller.readOnlyCardDetails.value,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Bank name cannot be empty";
                            if (!RegExp(r'^[a-zA-Z\s]+$')
                                .hasMatch(value.trim())) {
                              return "Bank name can only contain letters, spaces";
                            }
                            if (value.trim().length < 3)
                              return "Bank name must be at least 3 characters long";
                            return null;
                          },
                        ),
                      ),
                      8.widthBox,
                      Obx(
                        () => customTextfield(
                          textEditingController:
                              controller.cardTypeEdittingController,
                          heading: card.tr,
                          textLabel: "${data['c_type']}",
                          readOnly: controller.readOnlyCardDetails.value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Card type cann't be empty";
                            }

                            // List of valid card types
                            const validCardTypes = [
                              'Visa Card',
                              'Master Card',
                              'Rupay Card',
                              'Maestro Card',
                              'credit Card',
                              'debit Card'
                            ];

                            // Validate the card type
                            if (!validCardTypes.contains(value.trim())) {
                              return "Invalid card type. Accepted types are: ${validCardTypes.join(', ')}";
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  10.heightBox,
                  Obx(
                    () => customTextfield(
                      textEditingController:
                          controller.cardHoldersNameEdittingController,
                      heading: cardHoldersName.tr,
                      textLabel: "${data['c_holders_name']}",
                      readOnly: controller.readOnlyCardDetails.value,
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
                  ),
                  10.heightBox,
                  Obx(
                    () => customTextfield(
                      textEditingController:
                          controller.cardNumberEdittingController,
                      heading: cardNumber.tr,
                      textLabel: "${data['c_number']}",
                      readOnly: controller.readOnlyCardDetails.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Card number cann't be empty";
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "Card number must contain only digits";
                        }
                        if (value.length < 13 || value.length > 19) {
                          return "Card number must be between 13 and 19 digits";
                        }
                        return null;
                      },
                    ),
                  ),
                  10.heightBox,
                  Obx(
                    () => PasswordCustomTextField(
                      textEditingController:
                          controller.cardPinEdittingController,
                      heading: cardPin.tr,
                      textLabel: pin,
                      suffixIcon2: IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: pin));
                            VxToast.show(context,
                                msg: passwordCopiedToClipboard.tr);
                          },
                          icon: const Icon(Icons.copy_rounded)),
                      readOnly: controller.readOnlyCardDetails.value,
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
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      Obx(
                        () => customTextfield(
                          textEditingController:
                              controller.expiryMonthEdittingController,
                          heading: expiryMonth.tr,
                          textLabel: "${data['c_expiry_month']}",
                          readOnly: controller.readOnlyCardDetails.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Expiry month cannot be empty";
                            }
                            // Check if the value is an integer
                            final month = int.tryParse(value);
                            if (month == null) {
                              return "Please enter a valid numeric month";
                            }
                            // Check if the month is in the valid range (1-12)
                            if (month < 1 || month > 12) {
                              return "Month must be between 1 and 12";
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => customTextfield(
                          textEditingController:
                              controller.expiryYearEdittingController,
                          heading: expiryYear.tr,
                          textLabel: "${data['c_expiry_year']}",
                          readOnly: controller.readOnlyCardDetails.value,
                          validator: (value) {
                            final currentYear = DateTime.now().year;

                            // Check if the field is empty
                            if (value == null || value.isEmpty) {
                              return "Expiry year cannot be empty";
                            }
                            // Check if the input is numeric
                            final year = int.tryParse(value);
                            if (year == null) {
                              return "Expiry year must be a valid number";
                            }
                            // Validate the year range
                            if (year < currentYear) {
                              return "Expiry year cannot be in the past";
                            }
                            // Optional: Restrict the maximum year (e.g., 20 years from now)
                            if (year > currentYear + 20) {
                              return "Expiry year is too far in the future";
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => customTextfield(
                          textEditingController:
                              controller.cvvEdittingController,
                          heading: cvv.tr,
                          textLabel: "${data['c_cvv']}",
                          readOnly: controller.readOnlyCardDetails.value,
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
                        ),
                      ),
                    ],
                  ),
                  30.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => controller.updateCardIsLoading.value
                              ? Center(child: loadingIndicator())
                              : controller.readOnlyCardDetails.value
                                  ? newCustomButton(
                                      editItem, whiteColor, mainColor, () {
                                      controller.readOnlyCardDetails(false);
                                    }, false)
                                  : newCustomButton(save, whiteColor, mainColor,
                                      () async {
                                      if (_formKey.currentState!.validate()) {
                                        controller.updateCardIsLoading(
                                            true); // Start loading

                                        await controller.updateCard(cardId);
                                         VxToast.show(context,
                                                msg: cardUpdatedSuccessfully.tr,
                                                position:
                                                    VxToastPosition.center);
                                        Get.back();
                                        controller.updateCardIsLoading(
                                            false); // Stop loading
                                        try {
                                          print("Data before update: $cardId");
                                          // Debugging
                                          if (data.containsKey(cardId)) {
                                            print(
                                                "Updating card with ID: ${cardId}"); // Debugging

                                            controller
                                                .readOnlyCardDetails(true);

                                            VxToast.show(context,
                                                msg: cardUpdatedSuccessfully.tr,
                                                position:
                                                    VxToastPosition.center);

                                            Get.back();
                                          } else {
                                            print(
                                                "Error: No valid 'id' found in data.");
                                            VxToast.show(context,
                                                msg:
                                                    "Error: No valid ID found.",
                                                position:
                                                    VxToastPosition.center);
                                          }
                                        } catch (e) {
                                          print("Error updating card: $e");
                                          VxToast.show(context,
                                              msg:
                                                  "Failed to update card ${cardId}",
                                              position: VxToastPosition.center);
                                        } finally {
                                          controller.updateCardIsLoading(
                                              false); // Stop loading
                                        }
                                      }
                                    }, false),
                        ),
                      ),
                      10.widthBox,
                      Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                        size: 24,
                      )
                          .box
                          .color(mainColor)
                          .customRounded(BorderRadius.circular(8))
                          .size(45, 45)
                          .make()
                          .onTap(() {
                        controller.deleteCard(cardId);
                        Get.back();
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
