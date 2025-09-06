import 'package:flutter/material.dart'; 
import 'package:guardx/views/password_screen/componenets/tag_button.dart';

Widget tagSpace(list) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
      children:
          List.generate(list.length, (index) => tagButton(list[index])));
}
