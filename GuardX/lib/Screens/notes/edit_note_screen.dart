import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/colors.dart';
import 'package:guardx/consts/strings.dart';
import 'package:guardx/controllers/notes_controlller.dart';
import 'package:guardx/model/note_model.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/custom_elevated_button.dart'; 

class EditNoteScreen extends StatelessWidget {
  final Note note; 
  final NotesController notesController = Get.put(NotesController());

  EditNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note.title);
    final noteController = TextEditingController(text: note.note);
    final bgColor = note.bgColor.obs;

    return Scaffold(
      appBar: AppBar(
        title: const BigText(
          text: 'Edit Note',
          color: AppColor.whiteColor,
        ),
        backgroundColor: AppColor.blackColor,
      ),
      backgroundColor: AppColor.blackColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: AppColor.whiteColor),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: AppColor.whiteColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
                indent: 10.0,
                endIndent: 10.0,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: noteController,
                maxLines: 10,
                style: const TextStyle(color: AppColor.whiteColor),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: AppColor.whiteColor),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.whiteColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: CustomElevatedButton(
                      text: AppText.save,
                      backgroundColor: AppColor.greenColor,
                      onPressed: () {
                        notesController.updateNote(
                          note.id,
                          titleController.text,
                          noteController.text,
                          bgColor.value,
                        );
                        Get.back();
                      },
                    ),
                  )
                   
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
