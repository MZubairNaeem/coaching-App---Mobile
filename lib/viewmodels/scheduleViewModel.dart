import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/Schedule.dart';

class SchduleViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> AddSchedule(Schedule schedule) async {
    String res = "Some error has occurred";
    try {
      await _firestore
          .collection('Schedule')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set(
            schedule.toJson(),
          );
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //retreive all schedules
  Future<List<Schedule>> getAllSchedules() async {
    List<Schedule> schedules = [];
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Schedule').get();
      querySnapshot.docs.forEach((element) {
        schedules.add(Schedule.fromSnap(element));
      });
    } catch (err) {
      print(err);
    }
    return schedules;
  }
}
