import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/main.dart';
import 'package:coachingapp/models/message_model.dart';
import 'package:coachingapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../models/chat_room_model.dart';

class ClientSideChat extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatRoom;
  final UserModel user;
  final User firebaseUser;
  const ClientSideChat(
      {Key? key,
      required this.targetUser,
      required this.chatRoom,
      required this.user,
      required this.firebaseUser})
      : super(key: key);

  @override
  State<ClientSideChat> createState() => _ClientSideChatState();
}

class _ClientSideChatState extends State<ClientSideChat> {
  // int timestamp = DateTime.now().millisecondsSinceEpoch;
  final _messageController = TextEditingController();
  void sendMessage() async {
    String msg = _messageController.text.trim();
    if (msg != "") {
      _messageController.clear();
      MessageModel newMessage = MessageModel(
          messageId: uuid.v1(),
          text: msg,
          sender: widget.user.uid,
          createdon: Timestamp.now(),
          seen: false);
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoom.chatroomid)
          .collection("messages")
          .doc(newMessage.messageId)
          .set(newMessage.toMap());
      widget.chatRoom.lastMessage = msg;
      widget.chatRoom.lastMessageTime = Timestamp.now();
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoom.chatroomid)
          .update(widget.chatRoom.toMap());
      //  FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatRoom.chatroomid).update(widget.chatRoom.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors().whiteColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors().darKShadowColor,
            ),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: screenHeight * 0.025,
                backgroundImage: NetworkImage(widget.targetUser.photoUrl),
              ),
              SizedBox(
                width: screenWidth * 0.04,
              ),
              Text(
                widget.targetUser.firstName,
                style: TextStyle(
                  color: AppColors().darKShadowColor,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("chatrooms")
                        .doc(widget.chatRoom.chatroomid)
                        .collection("messages")
                        .orderBy("createdon", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          QuerySnapshot dataSnapshot =
                              snapshot.data as QuerySnapshot;
                          return ListView.builder(
                            reverse: true,
                            itemCount: dataSnapshot.docs.length,
                            itemBuilder: (context, index) {
                              MessageModel message = MessageModel.fromMap(
                                  dataSnapshot.docs[index].data()
                                      as Map<String, dynamic>);
                              bool isMe = message.sender == widget.user.uid;

                              String name = isMe
                                  ? widget.user.firstName
                                  : widget.targetUser.firstName;
                              Widget img = isMe
                                  ? Image.network(
                                      "https://images.unsplash.com/photo-1683537687366-5d1be66f75e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60")
                                  : Image.network(
                                      "https://images.unsplash.com/photo-1682917265562-139c5aa7070c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60");

                              String time =
                                  "${message.createdon?.toDate().hour}:${message.createdon?.toDate().minute}";

                              return ChatBubble(
                                message: message.text.toString(),
                                time: time,
                                isMe: isMe,
                                name: name,
                                img: img,
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        } else {
                          return const Center(
                              child: Text("Start a conversation"));
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              // child: ListView.builder(
              //   itemCount: 10, // Replace with your own data
              //   itemBuilder: (BuildContext context, int index) {
              //     // Replace with your own data
              //     final bool isMe = index % 2 == 0; // For demo purposes only
              //     final String name = isMe ? 'Me' : 'John Doe';
              //     final String message = isMe ? 'Hello!' : 'Hi there!';
              //     const String time = '3:30 PM'; // Replace with message time
              //     Widget img = isMe ? Image.network("https://images.unsplash.com/photo-1683537687366-5d1be66f75e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60"):Image.network("https://images.unsplash.com/photo-1682917265562-139c5aa7070c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60");

              //     return ChatBubble(
              //       message: message,
              //       time: time,
              //       isMe: isMe,
              //       name: name,
              //       img: img,
              //     );
              //   },
              // ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  //   child: IconButton(
                  //     icon: const Icon(Icons.photo_camera),
                  //     onPressed: () {
                  //       // TODO: Implement camera functionality
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Flexible(
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Enter a message',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        sendMessage();
                        // TODO: Implement sending functionality
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final String name;
  final Widget img;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isMe,
    required this.name,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final BorderRadius borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20.0),
      topRight: const Radius.circular(20.0),
      bottomLeft:
          isMe ? const Radius.circular(20.0) : const Radius.circular(0.0),
      bottomRight:
          isMe ? const Radius.circular(0.0) : const Radius.circular(20.0),
    );
    String img1 =
        "https://images.unsplash.com/photo-1683537687366-5d1be66f75e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60";
    String img2 =
        "https://images.unsplash.com/photo-1682917265562-139c5aa7070c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   backgroundImage: NetworkImage(isMe ? img1 : img2),
              //   radius: screenWidth * 0.03,
              // ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: borderRadius,
                    color: isMe ? AppColors().senderColor : Colors.blue[100],
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth * 0.7,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Text(time),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
