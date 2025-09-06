import 'dart:ui';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:guardx/consts/colors.dart';
import 'package:guardx/model/note_model.dart';

class NotesController extends GetxController {
  var title = ''.obs;
  var notes = ''.obs;
  var searchQuery = ''.obs;
  var savedNotes = <Note>[].obs;
  var backgroundColor = AppColor.blackColor.obs;
  var notebackgroundColor = const Color(0xFF2B334E).obs;

  final String userId =
      FirebaseAuth.instance.currentUser!.uid; // Get current user's UID

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  CollectionReference get notesCollection => userCollection
      .doc(userId)
      .collection('notes'); // Access notes subcollection

  @override
  void onInit() {
    super.onInit();
    fetchNotesFromFirebase();
  }

  void changeBackgroundColor(Color color) {
    notebackgroundColor.value = color;
  }

  void saveNote() async {
    if (title.isNotEmpty && notes.isNotEmpty) {
      String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

      Note note = Note(
        title: title.value,
        note: notes.value,
        date: formattedDate,
        bgColor: notebackgroundColor.value,
        userId: userId,
      );

      // Add to subcollection under the current user
      DocumentReference docRef = await notesCollection.add({
        'title': note.title,
        'note': note.note,
        'date': note.date,
        'bgColor': note.bgColor.value,
        'userId': note.userId,
      });

      note.id = docRef.id;
      savedNotes.add(note);
      title.value = '';
      notes.value = '';
    }
  }

  void fetchNotesFromFirebase() async {
    QuerySnapshot querySnapshot =
        await notesCollection.get(); // Fetch notes from subcollection

    savedNotes.clear();
    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      Note note = Note(
        id: doc.id,
        title: data['title'],
        note: data['note'],
        date: data['date'],
        bgColor: Color(data['bgColor']),
        userId: data['userId'],
      );
      savedNotes.add(note);
    }
  }

  List<Note> get filteredNotes {
    if (searchQuery.value.isEmpty) {
      return savedNotes;
    } else {
      return savedNotes
          .where((note) => note.title
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void deleteNoteAtIndex(int index) {
    var note = savedNotes[index];

    savedNotes.removeAt(index);
    if (note.id.isNotEmpty) {
      notesCollection.doc(note.id).delete(); // Delete from subcollection
    }
  }

  void updateNote(String id, String title, String note, Color bgColor) async {
    String updatedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

    await notesCollection.doc(id).update({
      'title': title,
      'note': note,
      'bgColor': bgColor.value,
      'date': updatedDate,
    });

    // Update the note locally
    int index = savedNotes.indexWhere((n) => n.id == id);
    if (index != -1) {
      savedNotes[index] = Note(
        id: id,
        title: title,
        note: note,
        date: updatedDate,
        bgColor: bgColor,
        userId: userId,
      );
    }
  }
}
