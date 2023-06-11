import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  String id;
  String title;
  String description;
  String CoachId;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
    required this.CoachId,
  });

  Schedule.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        CoachId = map['CoachId'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'CoachId': CoachId,
      };

  static Schedule fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Schedule(
      id: snapshot['id'],
      title: snapshot['title'],
      description: snapshot['description'],
      CoachId: snapshot['CoachId'],
    );
  }
}
