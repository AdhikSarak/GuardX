 
// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/document_controller.dart';
import 'package:guardx/utils/widgets/custom_button%20copy.dart';
import 'package:guardx/utils/widgets/custom_textfield.dart'; 
import 'package:guardx/views/add_password/components/added_document_list.dart';
import 'package:guardx/views/add_password/components/type_selector_space.dart'; 

class AddDocumentScreen extends StatefulWidget {
  const AddDocumentScreen({super.key});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DocumentController());
    return Scaffold(
        appBar: AppBar(
          title: saveADocument.tr.text
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                documentTypeSpace(),
                30.heightBox,
                customTextfield(
                    textEditingController: controller.documentTitleController,
                    heading: title.tr,
                    textLabel: aadhar.tr),
                10.heightBox,
                customTextfield(
                    textEditingController:
                        controller.documetnIdNumberController,
                    heading: yourIDNumber.tr,
                    textLabel: "1234567890123456".tr),
                10.heightBox,
                customTextfield(
                    textEditingController: controller.documentNoteController,
                    heading: note.tr,
                    textLabel: noteHere.tr),
                130.heightBox,
                AddedDocumentList(),
                10.heightBox,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: newCustomButton(
                          saveDocument, whiteColor, mainColor, () async {
                        controller.addDocumentToDatabase(context);
                      }, false),
                    ),
                    10.widthBox,
                    IconButton(
                        onPressed: () async {
                          var (addedFile, fileName) =
                              await controller.encryptFile();
                          controller.addedPasswordList.add(addedFile);
                          controller.addedPasswordTitleList
                              .add(fileName.toString());
                          print(controller.addedPasswordTitleList);
                          print(
                              controller.addedPasswordTitleList[0].runtimeType);
                          print(controller.addedPasswordList);
                          setState(() {});
                        },
                        icon: Icon(Icons.attachment)),
                    /*
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.attachment_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      //onSelected: choiceAction,
                      itemBuilder: (BuildContext context) {
                        return fileIconType;
                      },
                    )
                        .box
                        .color(mainColor)
                        .customRounded(BorderRadius.circular(8))
                        .size(45, 45)
                        .make(),
                        */
                    /*
                    DropdownButton(
                    //isDense: false,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    borderRadius: BorderRadius.circular(20),
                    items: sortByDropdownItems,
                    onChanged: (value) {},
                    hint: latestSave.tr.text.size(12).color(whiteColor).fontFamily(medium).make(),
                    elevation: 8,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    iconEnabledColor: whiteColor,
                    underline: const SizedBox(),
                    alignment: Alignment.centerLeft,
                  ),*/
                    //Icon(Icons.attachment_rounded).box.color(mainColor).size(45, 45).customRounded(BorderRadius.circular(8)).make().onTap(() {}),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
