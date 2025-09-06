// FirebaseServices.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardx/consts/firebase_helper.dart';

// Get current user's UID
final String userId = currentUser!.uid;

final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

CollectionReference get passwordCollection => userCollection
    .doc(userId)
    .collection('passwords'); // Access passwords subcollection

class FirebaseServices {
  static Stream<QuerySnapshot> getRecentlyAddedPasswords(String docId) {
    return passwordCollection
        .orderBy('p_created_At', descending: true)
        .limit(5)
        .snapshots();
  }

  static Stream<QuerySnapshot> getRecentlyUpdatedPasswords(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('passwords')
        .orderBy('p_updated_at', descending: true)
        .limit(5)
        .snapshots();
  }

  static Stream<QuerySnapshot> getFavouritePasswords(String uid) {
    return passwordCollection
        .where('p_user', isEqualTo: uid)
        .where('p_favourites', isEqualTo: true)
        .orderBy('p_updated_at', descending: true)
        .snapshots();
  }

  static Future<QuerySnapshot> getAllSecrets(String uid) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('passwords')
        .get();
  }

  static Stream<QuerySnapshot> getDocuments(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('documents') // Assuming "documents" subcollection
        .snapshots();
  }
}
