import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String firstName;
  String email;
  String location;
  String dateOfBirth;
  String photoUrl;
  String phoneNumber;
  String userType;
  String? title;
  String? experience;
  String? projects;

  UserModel(
      {required this.uid,
      required this.firstName,
      required this.email,
      required this.location,
      required this.dateOfBirth,
      required this.phoneNumber,
      required this.userType,
      required this.photoUrl,
      this.title,
      this.experience,
      this.projects
      });
  UserModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        firstName = map['firstName'],
        email = map['email'],
        location = map['location'],
        dateOfBirth = map['dateOfBirth'],
        phoneNumber = map['phoneNumber'],
        photoUrl = map['photoUrl'],
        userType = map['userType'],
        title = map['title'],
        experience = map['experience'],
        projects = map['projects']
        ;


  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstName': firstName,
        'email': email,
        'location': location,
        'dateOfBirth': dateOfBirth,
        'phoneNumber': phoneNumber,
        'userType': userType,
        'photoUrl': photoUrl,
        'title': title,
        'experience': experience,
        'projects': projects,

      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      firstName: snapshot['firstName'],
      email: snapshot['email'],
      location: snapshot['location'],
      dateOfBirth: snapshot['dateOfBirth'],
      phoneNumber: snapshot['phoneNumber'],
      userType: snapshot['userType'],
      photoUrl: snapshot['photoUrl'],
      title: snapshot['title'],
      experience: snapshot['experience'],
      projects: snapshot['projects'],
    );
  }
}
