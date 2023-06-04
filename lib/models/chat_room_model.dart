class ChatRoomModel {
  String? chatroomid;
  String? participant;
  ChatRoomModel({this.chatroomid, this.participant});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map['id'];
    participant = map['participant'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': chatroomid,
      'participant': participant,
    };
  }
}
