import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/user.dart';

import '../models/coach_app_sub.dart';

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
  static Future<CoachAppSubModel> getCoachSubModelById(String uid) async {
    CoachAppSubModel? coachAppSubModel;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentSnapshot docSnap =
        await firestore.collection('CoachAppSub').doc(uid).get();
    if (docSnap.data() != null) {
      coachAppSubModel = CoachAppSubModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
    return coachAppSubModel!;
  }
}
