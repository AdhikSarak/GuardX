import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/Screens/profile_Screen/about_Guardx.dart';
import 'package:guardx/Screens/profile_Screen/help.dart';
import 'package:guardx/Screens/profile_Screen/privecy_policy.dart';
import 'package:guardx/controllers/user_controller.dart';
import 'package:guardx/utils/widgets/curve.dart';
import 'package:guardx/utils/widgets/logout_dialog.dart';
import 'package:guardx/utils/widgets/profilebtn.dart';
import 'package:guardx/views/account_screen/change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ClipPath(
            clipper: CurvedClipper(),
            child: Container(
              height: 150,
              color: Colors.purple,
            ),
          ),
          Obx(() {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white),
                        onPressed: () {
                          showLogoutDialog(context);
                          print("logout");
                          // userController.clearUserData();
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 50,
                        backgroundImage: userController
                                .profileImageUrl.value.isNotEmpty
                            ? NetworkImage(userController.profileImageUrl.value)
                            : AssetImage('assets/images/userImage.png')
                                as ImageProvider),
                    Text(
                      userController.username.value.isNotEmpty
                          ? userController.username.value
                          : "User Name",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      userController.userEmail.value.isNotEmpty
                          ? userController.userEmail.value
                          : "abc@xyz.com",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, right: 10),
                      child: GestureDetector(
                        onTap: () => Get.to(() => const GaurdXImp()),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.health_and_safety_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Guardx Importance",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white60),
                    const SizedBox(height: 30),
                    // ProfileBtn(
                    //   ontap: () => Get.to(const EditProfile()),
                    //   prefixIcon: Icons.edit_square,
                    //   labelText: "Edit Profile",
                    //   descriptionText: 'Edit your profile..',
                    // ),
                    // const SizedBox(height: 10),
                    // ProfileBtn(
                    //   ontap: () => Get.to(LanguageScreen()),
                    //   prefixIcon: Icons.translate,
                    //   labelText: 'Language',
                    //   descriptionText: 'Change language ...',
                    // ),
                    // const SizedBox(height: 10),
                    ProfileBtn(
                      ontap: () => Get.to(const ChangePasswordScreen()),
                      prefixIcon: Icons.change_circle_sharp,
                      labelText: 'Change Password',
                      descriptionText: 'Password is Average Secure',
                    ),
                    const SizedBox(height: 10),
                    ProfileBtn(
                      ontap: () => Get.to(const HelpScreen()),
                      prefixIcon: Icons.help,
                      labelText: 'Help',
                      descriptionText: 'Help Center, Contact Us',
                    ),
                    const SizedBox(height: 10),
                    ProfileBtn(
                      ontap: () => Get.to(PrivacyPolicyScreen()),
                      prefixIcon: Icons.privacy_tip_rounded,
                      labelText: 'Privacy Policy',
                      descriptionText: 'Read more.....',
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
