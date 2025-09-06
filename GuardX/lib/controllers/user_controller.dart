import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardx/utils/helper/helper.dart';

class UserController extends GetxController {
  var userEmail = ''.obs;
  var username = ''.obs;
  var profileImageUrl = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    logger.i("UserController onInit called");
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    logger.i("UserController's fetchUserDetails called");
    User? user = _auth.currentUser;

    // Step 1: Check if a user is logged in
    if (user != null) {
      logger.i("Current user UID: ${user.uid}");
      logger.i("Current user email: ${user.email}");

      try {
        // Step 2: Fetch user document from Firestore
        String documentPath = 'users/${user.uid}';
        logger.i("Attempting to fetch Firestore document at: $documentPath");

        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          logger.i("User document found: ${userSnapshot.data()}");

          // Step 3: Update observable variables
          userEmail.value = userSnapshot.data()?['email'] ?? '';
          username.value = userEmail.value.isNotEmpty
              ? userEmail.value.split('@')[0]
              : 'No username';

          profileImageUrl.value = userSnapshot.data()?['profileImageUrl'] ?? '';
          logger.i("Fetched user details: Email - $userEmail, Username - $username, ProfileImage - $profileImageUrl");
        } else {
          logger.w("User document does not exist in Firestore.");
          clearUserData();
        }
      } catch (e, stackTrace) {
        // Step 4: Log errors with stack trace for detailed debugging
        logger.e("Error fetching user details: $e", );
        clearUserData();
      }
    } else {
      logger.w("No user is currently logged in.");
      clearUserData();
    }
  }

  void clearUserData() {
    userEmail.value = '';
    username.value = '';
    profileImageUrl.value = '';
    logger.i("User data cleared");
  }
}
