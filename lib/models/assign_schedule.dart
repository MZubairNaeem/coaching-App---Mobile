import 'package:cloud_firestore/cloud_firestore.dart';

class AssignSchedule {
  String? id;
  String? scheduleId;
  String? coachId;
  List<dynamic>? videos;
  List<dynamic>? clients;
  Timestamp? assignDate;
  Timestamp? created_at;

  AssignSchedule(
      {this.id,
      this.coachId,
      this.scheduleId,
      this.videos,
      this.clients,
      this.assignDate,
      this.created_at});

  AssignSchedule.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    scheduleId = map['scheduleId'];
    coachId = map['coachId'];
    videos = map['videos'];
    clients = map['clients'];
    assignDate = map['assignDate'];
    created_at = map['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduleId': scheduleId,
      'coachId': coachId,
      'videos': videos,
      'clients': clients,
      'assignDate': assignDate,
      'created_at': created_at,
    };
  }
}
