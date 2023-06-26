import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/coach_sub_plan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coachOwnScheduleProvider =
    FutureProvider<List<CoachSubPlanModel>>((ref) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('CoachSubPlan')
      .where('coachId', isEqualTo: user!.uid)
      .get();

  List<CoachSubPlanModel> coachSubPlanModel = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return CoachSubPlanModel(
      coachId: data['coachId'],
      subscriptionId: data['subscriptionId'],
      subscriptionType: data['subscriptionType'],
      timeline: data['timeline'],
      price: data['price'],
      description: data['description'],
    );
  }).toList();

  return coachSubPlanModel;
});

final getCoachTotalScheduleProvider =
    FutureProvider.family<int, String?>((ref, id) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('CoachSubPlan')
      .where('coachId', isEqualTo: id)
      .get();
  return snapshot.docs.length;
});
