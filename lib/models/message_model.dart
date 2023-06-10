import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  Timestamp? createdon;
  bool? seen;

  MessageModel({this.messageId, this.sender, this.text, this.createdon, this.seen,});
  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map['MessageId'];
    sender = map['sender'];
    text = map['text'];
    createdon = map['createdon'];
    seen = map['seen'];
  }
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'sender': sender,
      'text': text,
      'createdon': createdon,
      'seen': seen,
    };
  }
}
