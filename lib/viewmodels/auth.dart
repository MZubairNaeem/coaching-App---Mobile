import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart' as model;
import '../models/videos.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<String> signUpUser({
    required String firstName,
    required String email,
    required String password,
    required String location,
    required String dateOfBirth,
    required String phoneNumber,
    required userType,
    required String photoUrl,
  }) async {
    String res = "Some error has occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User? userr = cred.user;
        // Send verification email to the user
        await userr?.sendEmailVerification();
        model.UserModel user = model.UserModel(
          uid: cred.user!.uid,
          firstName: firstName,
          location: location,
          dateOfBirth: dateOfBirth,
          phoneNumber: phoneNumber,
          email: email,
          userType: userType,
          photoUrl: photoUrl,
        );
        await _firestore.collection('Users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Future<String> loginUser(
  //     {required String email, required String password}) async {
  //   String id = "Empty";
  //   try {
  //     if (email.isNotEmpty || password.isNotEmpty) {
  //       UserCredential user = await _auth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //       if (user.user!.uid.isNotEmpty) {
  //         print(user.user!.uid);
  //
  //         id = user.user!.uid;
  //       }
  //     } else {
  //       return "Please Enter all the fields";
  //     }
  //   } catch (err) {
  //     id = err.toString();
  //   }
  //   return id;
  // }

  Future<model.UserModel> getUserDetails(var id) async {
    String res = "Some error has occur";
    try {
      if (id.isNotEmpty) {
        print(id);
        DocumentSnapshot doc =
            await _firestore.collection('Users').doc(id).get();
        res = doc.data().toString();
        res = jsonEncode(doc.data());
        var data = await jsonDecode(res);
        return model.UserModel(
            firstName: data['firstName'],
            uid: data['uid'],
            location: data['location'],
            dateOfBirth: data['dateOfBirth'],
            phoneNumber: data['phoneNumber'],
            email: data['email'],
            userType: data['userType'],
            photoUrl: data['photoUrl']);
      } else {
        res = "Please Enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return model.UserModel(
        uid: "Empty",
        firstName: "Empty",
        location: "Empty",
        dateOfBirth: "Empty",
        phoneNumber: "Empty",
        email: "Empty",
        userType: "Empty",
        photoUrl: "Empty");
  }

  Future forgetPass({required String email}) async {
    String res = "Some error has occur";
    try {
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
        res = "Success";
      } else {
        res = "Please Enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future StoreVideos(Video Videos) async {
    String res = "Some error has occur";
    try {
      //register user
      await FirebaseFirestore.instance
          .collection('Videos')
          .doc(Videos.videoId)
          .set({
        'videoId': Videos.videoId,
        'videoTitle': Videos.videoTitle,
        'videoDescription': Videos.videoDescription,
        'videoUrl': Videos.videoUrl,
        'videoThumbnail': Videos.videoThumbnail
      });
      await FirebaseFirestore.instance
          .collection('DemoVideos')
          .doc(Videos.videoId)
          .set({
        'videoId': Videos.videoId,
        'CoachId': _auth.currentUser!.uid,
      });

      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Subcribe to coach
  Future<String> Subscirbe(String coachId) async {
    var userId = _auth.currentUser!.uid;
    try {
      await _firestore
          .collection('Subscriptions')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set({'subscriber': userId, 'subscribed': coachId});
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> checkSubscription(String coachId) async {
    var userId = _auth.currentUser!.uid;
    try {
      var data = await _firestore
          .collection('Subscriptions')
          .where('subscriber', isEqualTo: userId)
          .where('subscribed', isEqualTo: coachId)
          .get();
      if (data.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
