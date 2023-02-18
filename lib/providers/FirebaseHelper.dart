import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hepler/providers/user.dart';

class FirebaseHelper {
  static Future<Customer?> getUserModelById(String uid) async {
    Customer? userModel;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = Customer.fromJson(docSnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }
}
