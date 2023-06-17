import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/assign_schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Schedule.dart';

class SchduleViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> AddSchedule(Schedule schedule) async {
    String res = "Some error has occurred";
    try {
      await _firestore.collection('Schedule').doc(schedule.id).set(
            schedule.toJson(),
          );
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //retreive all schedules
  Stream<List<Schedule>> getAllSchedules() async* {
    List<Schedule> schedules = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Schedule')
          .where('CoachId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      for (var element in querySnapshot.docs) {
        schedules.add(Schedule.fromSnap(element));
      }
    } catch (err) {
      print(err);
    }
    yield schedules;
  }

  //Assign Schedule
  Future<String> AssignedSchedules(AssignSchedule assignSchedule) async {
    String res = "Some error has occurred";
    try {
      await _firestore
          .collection('AssignedSchedule')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set(
            assignSchedule.toJson(),
          );
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
