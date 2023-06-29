import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/coach_sub_plan.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showCoachScheduleProvider =
    FutureProvider.family<List<CoachSubPlanModel> , String?>((ref, id) async { 
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('CoachSubPlan')
      .where('coachId', isEqualTo: id)
      .get();

  List<CoachSubPlanModel> showCoachSchedule = doc.docs.map((snapshot) {
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

  return showCoachSchedule;
});
