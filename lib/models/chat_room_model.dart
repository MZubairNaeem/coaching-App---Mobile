import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? participant;
  String? lastMessage;
  Timestamp? lastMessageTime;
  List<dynamic>? users;
  ChatRoomModel({this.chatroomid, this.participant, this.lastMessage, this.lastMessageTime, this.users});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map['id'];
    participant = map['participant'];
    lastMessage = map['lastMessage'];
    lastMessageTime = map['lastMessageTime'];
    users = map['users'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': chatroomid,
      'participant': participant,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'users': users,
    };
  }
}
