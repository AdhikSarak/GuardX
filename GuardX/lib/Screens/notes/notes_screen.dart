import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/notes_controlller.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final NotesController notesController = Get.put(NotesController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          color: notesController.notebackgroundColor.value,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                      color: AppColor.whiteColor,
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                          color: AppColor.whiteColor, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _titleController,
                  onChanged: (value) => notesController.title.value = value,
                  style: const TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Note Title";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Note Title",
                    hintStyle: TextStyle(
                        color: AppColor.whiteColor, fontFamily: 'Inter'),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TextField(
                    controller: _notesController,
                    onChanged: (value) => notesController.notes.value = value,
                    style: const TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 18,
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Write your notes here...",
                      hintStyle: TextStyle(
                          color: AppColor.whiteColor, fontFamily: 'Inter'),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => notesController
                              .changeBackgroundColor(AppColor.notesThemeColor1),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: AppColor.notesThemeColor1,
                              radius: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => notesController
                              .changeBackgroundColor(AppColor.notesThemeColor2),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: AppColor.notesThemeColor2,
                              radius: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => notesController
                              .changeBackgroundColor(AppColor.notesThemeColor3),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColor.notesThemeColor3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 50),
                    CustomElevatedButton(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      text: AppText.save,
                      backgroundColor: AppColor.greenColor,
                      borderColor: AppColor.greenColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          notesController.saveNote();
                          Get.back();
                        }
                      },
                    ),
                    const SizedBox(height: 100),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.greenColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          notesController.title.value = '';
                          notesController.notes.value = '';
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
