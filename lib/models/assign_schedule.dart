import 'package:cloud_firestore/cloud_firestore.dart';

class AssignSchedule {
  String? id;
  String? scheduleId;
  String? coachId;
  List<dynamic>? videos;
  List<dynamic>? clients;
  Timestamp? assignDate;

  AssignSchedule(
      {this.id,
      this.coachId,
      this.scheduleId,
      this.videos,
      this.clients,
      this.assignDate});

  AssignSchedule.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    scheduleId = map['scheduleId'];
    coachId = map['coachId'];
    videos = map['videos'];
    clients = map['clients'];
    assignDate = map['assignDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduleId': scheduleId,
      'coachId': coachId,
      'videos': videos,
      'clients': clients,
      'assignDate': assignDate,
    };
  }
}
