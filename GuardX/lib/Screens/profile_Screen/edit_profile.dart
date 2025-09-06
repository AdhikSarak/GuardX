import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/colors.dart';
import 'package:guardx/consts/strings.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
          color: AppColor.whiteColor,
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 40,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_square,
                  color: Colors.white,
                ),
                Text(
                  "Change profile",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Username",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 6,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(height: 30),
            const Text(
              "Email I'd",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 6,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(height: 30),
            const Text(
              "Phone Number",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 6,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(height: 30),
            const Center(
                child: SizedBox(
              width: 400,
              child: CustomElevatedButton(
                text: AppText.save,
                backgroundColor: AppColor.mainColor,
                borderColor: AppColor.mainColor,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
