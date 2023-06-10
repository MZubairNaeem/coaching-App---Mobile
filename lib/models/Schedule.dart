import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  String id;
  String title;
  String description;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
  });

  Schedule.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };

  static Schedule fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Schedule(
      id: snapshot['id'],
      title: snapshot['title'],
      description: snapshot['description'],
    );
  }
}
