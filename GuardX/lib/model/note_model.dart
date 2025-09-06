import 'dart:ui';

class Note {
  String id;
  String userId;
  String title;
  String note;
  String date;
  Color bgColor;

  Note({
    this.id = '', 
    required this.userId,
    required this.title,
    required this.note,
    required this.date,
    required this.bgColor,
  });
}
