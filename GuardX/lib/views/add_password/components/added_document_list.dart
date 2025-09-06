import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/colors.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/document_controller.dart';

class AddedDocumentList extends StatefulWidget {
  const AddedDocumentList({super.key});

  @override
  State<AddedDocumentList> createState() => _AddedDocumentListState();
}

class _AddedDocumentListState extends State<AddedDocumentList> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DocumentController());
    return Column(
      children: List.generate(
        controller.addedPasswordList.length,
        (index) => Card(
          color: cardGrey,
          margin: const EdgeInsets.all(7),
          elevation: 0,
          child: ListTile(
            //title: Text(data)
            title: "${controller.addedPasswordTitleList[index]}"
                .text
                .size(14)
                .color(whiteColor)
                .fontFamily(semibold)
                .make(),
            //subtitle: recentUsedTextList[index].text.size(10).color(whiteColor).fontFamily(medium).make(),

            //title: "${data[index]['p_website_name']}".text.size(15).semiBold.make(),
            //subtitle: "${data[index]['p_email_username']}".text.make(),

            trailing: IconButton(
              onPressed: () async {},
              //icon: )),
              icon: const Icon(Icons.close),
            ),
          ),
        ).onTap(() async {}),
      ),
    );
  }
}
