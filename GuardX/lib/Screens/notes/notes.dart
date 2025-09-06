import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/Screens/notes/edit_note_screen.dart';
import 'package:guardx/Screens/notes/notes_screen.dart';
import 'package:guardx/consts/colors.dart';
import 'package:guardx/controllers/notes_controlller.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/small_text.dart';

class Notes extends StatelessWidget {
  Notes({super.key});
  final NotesController notesController = Get.put(NotesController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextField(
                  style: const TextStyle(
                    color: AppColor.whiteColor,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColor.whiteColor,
                    ),
                    hintText: "Search here...",
                    hintStyle: const TextStyle(color: AppColor.whiteColor),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: AppColor.whiteColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    notesController.searchQuery.value = value;
                    notesController.filteredNotes.length;
                  },
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: SizedBox(
                    height: height - 243,
                    child: Obx(() {
                      if (notesController.filteredNotes.isEmpty) {
                        return Center(
                          child: Text(
                            "No notes available",
                            style: const TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: notesController.filteredNotes.length,
                        itemBuilder: (context, index) {
                          final note = notesController.filteredNotes[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => EditNoteScreen(note: note));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: note.bgColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: const TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SmallText(
                                    text: note.note,
                                    color: AppColor.whiteColor,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        note.date,
                                        style: const TextStyle(
                                            color: AppColor.whiteColor),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          notesController
                                              .deleteNoteAtIndex(index);
                                        },
                                        icon: const Icon(
                                          Icons.delete_outlined,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColor.greenColor,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        ),
        onPressed: () => Get.to(() => NotesScreen()),
        child: const BigText(
          text: "Add note",
          size: 20,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }
}
