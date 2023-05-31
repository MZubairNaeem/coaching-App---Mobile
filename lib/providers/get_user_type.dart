import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  String res = "Some error has occurred";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot doc = await _firestore
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  res = doc.data().toString();
  res = jsonEncode(doc.data());
  var data = await jsonDecode(res);
  return UserModel(
    firstName: data['firstName'],
    uid: data['uid'],
    location: data['location'],
    dateOfBirth: data['dateOfBirth'],
    phoneNumber: data['phoneNumber'],
    email: data['email'],
    userType: data['userType'],
  );
});
