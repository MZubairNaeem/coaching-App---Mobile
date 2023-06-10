import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/user.dart';

class FirebaseHelper {
  static Future<UserModel> getUserModelById(String uid) async {
    UserModel? userModel;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentSnapshot docSnap =
        await firestore.collection('Users').doc(uid).get();
    if (docSnap.data() != null) {
      userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
    return userModel!;
  }
}
