import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

final subscribed_coaches = FutureProvider<List<UserModel>>((ref) async {
  String res = "Some error has occurred";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Getting all the subscribed coaches ids
  QuerySnapshot<Map<String, dynamic>> doc = await _firestore
      .collection('Subscriptions')
      .where('subscriber', isEqualTo: _auth.currentUser!.uid)
      .get();

  List subscribed_coaches_ids = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return data['subscribed'];
  }).toList();
  //Getting all the subscribed coaches
  doc = await _firestore
      .collection('Users')
      .where('userType', isEqualTo: 'coachKey')
      .where('uid', whereIn: subscribed_coaches_ids)
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
    );
  }).toList();
  return userModels;
});
