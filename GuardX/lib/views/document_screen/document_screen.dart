// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:guardx/consts/index.dart';
// import 'package:guardx/services/firebase_services.dart';
// import 'package:guardx/utils/widgets/loading_indicator.dart';
// import 'package:guardx/utils/widgets/search_bar.dart';
// import 'package:guardx/views/document_screen/components/document_list.dart';

// class DocumentScreen extends StatelessWidget {
//   const DocumentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         width: context.screenWidth,
//         height: context.screenHeight,
//         child: SafeArea(
//           child: Column(
//             children: [
//               searchBar(search.tr, context),
//               10.heightBox,
//               // Expanded(
//               //     child: SingleChildScrollView(
//               //         child: StreamBuilder(
//               //   stream: FirebaseServices.getDocuments(currentUser!.uid),
//               //   builder: (BuildContext context,
//               //       AsyncSnapshot<QuerySnapshot> snapshot) {
//                   // if (!snapshot.hasData) {
//                   //   return Center(child: loadingIndicator());
//                   // } else if (snapshot.data!.docs.isEmpty) {
//                   //   return Center(
//                   //     child: nothingAddedYet.tr.text.make(),
//                   //   );
//                   // } 
//                   // else
//                   //  {
//                   //   var data = snapshot.data!.docs;
//                   //   return  documentList(context, data);
                    
//                   // }
//                 // },
//               // ))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
