import 'package:cloud_firestore/cloud_firestore.dart';

class CoachAppSubModel {
  String? coachId;
  String? subscriptionType;
  Timestamp? startDate;
  Timestamp? endDate;
  int? noOfClients;
  String? status;

  CoachAppSubModel({
    this.coachId,
    this.subscriptionType,
    this.startDate,
    this.endDate,
    this.noOfClients,
    this.status,
  });

  CoachAppSubModel.fromMap(Map<String, dynamic> map) {
    coachId = map['coachId'];
    subscriptionType = map['subscriptionType'];
    startDate = map['startDate'];
    endDate = map['endDate'];
    noOfClients = map['noOfClients'];
    status = map['status'];
  }
  Map<String, dynamic> toMap() {
    return {
      'coachId': coachId,
      'subscriptionType': subscriptionType,
      'startDate': startDate,
      'endDate': endDate,
      'noOfClients': noOfClients,
      'status': status,
    };
  }
}
