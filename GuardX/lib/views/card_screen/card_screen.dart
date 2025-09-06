 import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart'; 
import 'package:guardx/utils/widgets/loading_indicator.dart';
import 'package:guardx/utils/widgets/search_bar.dart';
import 'package:guardx/views/card_screen/components/card_list.dart'; //Import

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: Column(
            children: [
              searchBar(search.tr, context),
              10.heightBox,
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseServices.getCards(currentUser!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      }

                      if (!snapshot.hasData) {
                        return Center(child: loadingIndicator());
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: nothingAddedYet.tr.text.make(),
                        );
                      }

                      var data = snapshot.data!.docs;
                      return cardList(context, data);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirebaseServices {
  static Stream<QuerySnapshot> getCards(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cards')
        .orderBy('c_created_At', descending: true) // Optional: Order by creation date
        .snapshots();
  }
}