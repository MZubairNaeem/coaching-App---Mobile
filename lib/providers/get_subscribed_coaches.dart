import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

final subscribedCoaches = FutureProvider<List<UserModel>>((ref) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    //Getting all the subscribed coaches ids
    QuerySnapshot<Map<String, dynamic>> doc = await firestore
        .collection('Subscriptions')
        .where('subscriber', isEqualTo: auth.currentUser!.uid)
        .get();

    List subscribedCoachesIds = doc.docs.map((snapshot) {
      Map<String, dynamic> data = snapshot.data();
      return data['subscribed'];
    }).toList();
    //Getting all the subscribed coaches
    doc = await firestore
        .collection('Users')
        .where('userType', isEqualTo: 'coachKey')
        .where('uid', whereIn: subscribedCoachesIds)
        .get();

    List<UserModel> userModels = doc.docs.map((snapshot) {
      Map<String, dynamic> data = snapshot.data();
      return UserModel(
        firstName: data['firstName'],
        uid: data['uid'],
        location: data['location'],
        dateOfBirth: data['dateOfBirth'],
        phoneNumber: data['phoneNumber'],
        email: data['email'],
        userType: data['userType'],
        photoUrl: data['photoUrl'],
      );
    }).toList();
    return userModels;
  } catch (e) {
    return [];
  }
});
