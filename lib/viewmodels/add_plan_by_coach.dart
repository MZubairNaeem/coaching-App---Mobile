import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/coach_sub_plan.dart';
String subscriptionId = uuid.v4();
Future<void> addCoachPlan(
  String? subscriptionType,
  String? timeline,
  int? price,
  String? description,
) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  CoachSubPlanModel coachSubPlan = CoachSubPlanModel(
    coachId: user!.uid,
    subscriptionId: subscriptionId,
    subscriptionType: subscriptionType,
    timeline: timeline,
    price: price,
    description: description,
  );
  await firestore
      .collection('CoachSubPlan')
      .doc(subscriptionId)
      .set(coachSubPlan.toMap());
  return;
}
