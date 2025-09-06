// import 'package:flutter/material.dart';  
// import 'package:kawach/consts/colors.dart';
// import 'package:kawach/consts/images.dart';
// import 'package:kawach/consts/strings.dart';
// import 'package:kawach/widgets/big_text.dart';
// import 'package:kawach/widgets/custom_elevated_button.dart';
// import 'package:kawach/widgets/small_text.dart';
// import 'package:velocity_x/velocity_x.dart';

// class ChangeEmailScreen extends StatefulWidget {
//   final String email;

//   const ChangeEmailScreen({super.key, required this.email});

//   @override
//   State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
// }

// class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _emailController.text = widget.email;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Center(
//           child: Column(
//             children: [
//               12.heightBox,
//               SizedBox(
//                 height: 200,
//                 child:  Image.asset(AppImages.logo)
//               ),
//               10.heightBox,
//               const BigText(
//                 text: AppText.codeSent,
//                 color: AppColor.mainColor,
//               ),
//               10.heightBox,
//               SmallText(
//                 text: '${AppText.codeSentRegEmail} ${widget.email}',
//                 align: TextAlign.center,
//               ),
//               30.heightBox,
//               const SizedBox(
//                 width: double.infinity,
//                 child: CustomElevatedButton(
//                   text: AppText.changeEmailL,
//                   textColor: AppColor.mainColor,
//                 ),
//               ),
//               12.heightBox,
//               const SizedBox(
//                 width: double.infinity,
//                 child: CustomElevatedButton(
//                   backgroundColor: AppColor.mainColor,
//                   text: AppText.submitToken,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
