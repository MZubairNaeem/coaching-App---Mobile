import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  String res = "Some error has occurred";
  // final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot doc = await firestore
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  res = doc.data().toString();
  res = jsonEncode(doc.data());
  var data = await jsonDecode(res);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userType', data['userType']);
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
});
