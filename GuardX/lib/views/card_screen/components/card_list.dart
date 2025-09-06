 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/card_controller.dart';
import 'package:guardx/views/card_screen/card_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

Widget cardList(BuildContext context, List<QueryDocumentSnapshot> data) {
  final CardController controller = Get.find();

  return Column(
    children: List.generate(
      data.length,
      (index) {
        final cardDocument = data[index]; // Get the QueryDocumentSnapshot
        final cardData = cardDocument.data() as Map<String, dynamic>; // Get the data
        final cardId = cardDocument.id; // Get the document ID

        return Card(
          color: cardGrey,
          margin: const EdgeInsets.all(7),
          elevation: 0,
          child: InkWell(
            onTap: () async {
              String pin = await controller.decryptSecret(cardData['c_pin']);
              Get.to(() => CardDetailsScreen(
                    data: cardData, // Pass the card data
                    pin: pin,
                    cardId: cardId, //Pass the cardId
                  ));
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "${cardData['c_type']}"
                      .text
                      .size(16)
                      .color(whiteColor)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "${cardData['c_holders_name']}"
                          .text
                          .size(16)
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .make(),
                      cvv.text
                          .size(16)
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .make(),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "${cardData['c_bank_name']}"
                          .text
                          .size(16)
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .make(),
                      "${cardData['c_cvv']}"
                          .text
                          .size(16)
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .make(),
                    ],
                  ),
                  10.heightBox,
                  "${cardData['c_number']}"
                      .text
                      .size(16)
                      .color(whiteColor)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Pin- ****"
                          .text
                          .size(16)
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .make(),
                      "${cardData['c_expiry_month']}/${cardData['c_expiry_year']}"
                          .text
                          .size(16)
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .make(),
                      const Icon(Icons.more_vert_rounded, color: whiteColor),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
