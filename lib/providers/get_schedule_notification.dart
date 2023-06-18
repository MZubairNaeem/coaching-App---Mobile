import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/assign_schedule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final NotificationProvider =
    StreamProvider.autoDispose<List<AssignSchedule>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  return FirebaseFirestore.instance
      .collection('AssignedSchedule')
      .where('clients', arrayContains: user!.uid)
      .orderBy('created_at', descending: true)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => AssignSchedule.fromMap(e.data())).toList())
      .handleError((e) {
    log(e);
  });
});

Future<String> getSchuduleTitle(String id) async {
  String title = '';
  await FirebaseFirestore.instance
      .collection('Schedule')
      .doc(id)
      .get()
      .then((value) {
    title = value.data()!['title'];
  });
  return title;
}
