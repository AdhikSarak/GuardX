import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/images.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/home_controller.dart';

Widget searchBar(textHint, context) {
  var controller = Get.put(HomeController());
  return TextFormField(
      controller: controller.searchController,
      decoration:InputDecoration(
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: whiteColor)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(width: 1, color: whiteColor)),
        hoverColor: Colors.transparent,
        filled: false,
        hintText: textHint,
        prefixIcon: const Image(image: AssetImage(searchIc))
      ),
  );
}
