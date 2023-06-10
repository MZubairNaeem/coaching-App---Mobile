import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/chat_room_model.dart';
import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/views/navscreens/chat/search_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import '../../../models/user.dart';
import '../../../providers/firebase_helper.dart';
import 'clientchat.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  UserModel? userModel;
  User? firebaseUser;
  final searchController = TextEditingController();
  Future<UserModel> getUserData() async {
    UserModel user = await FirebaseHelper.getUserModelById(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userModel = user;
    });
    return user;
  }

  void getfirebaseUser() async {
    User user = FirebaseAuth.instance.currentUser!;
    setState(() {
      firebaseUser = user;
    });
  }

  @override
  void initState() {
    getUserData();
    getfirebaseUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors().whiteColor,
          title: Text(
            "Chat",
            style: TextStyle(color: AppColors().darKShadowColor),
          ),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchUser(
                      firebaseUser: firebaseUser!,
                      userModel: userModel!,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Container(
                  height: size.height * 0.06,
                  color: Colors.grey[200],
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.search,
                          color: AppColors().darKShadowColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors().darKShadowColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chatrooms')
                  .where("users", arrayContains: userModel?.uid)
                  .orderBy('lastMessageTime', descending: true)
                  .snapshots(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.active) {
                  if (snap.hasData) {
                    QuerySnapshot? chatRoomSnapshot = snap.data;
                    return ListView.builder(
                      itemCount: chatRoomSnapshot!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                            chatRoomSnapshot.docs[index].data()
                                as Map<String, dynamic>);
                        Map<String, dynamic>? participant =
                            chatRoomModel.participant;
                        List<String> participantKeys =
                            participant!.keys.toList();
                        participantKeys.remove(userModel?.uid);
                        return FutureBuilder(
                          future: FirebaseHelper.getUserModelById(
                              participantKeys[0]),
                          builder: (context, userData) {
                            if (userData.connectionState ==
                                ConnectionState.done) {
                              if (userData.data != null) {
                                UserModel? targetUser = userData.data;
                                DateTime dateTime = chatRoomModel
                                    .lastMessageTime!
                                    .toDate(); // Convert Firebase Timestamp to DateTime
                                DateTime now = DateTime.now();
                                String formattedTime =
                                    DateFormat.jm().format(dateTime);
                                String formattedDate =
                                    DateFormat.yMd().format(dateTime);
                              
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClientSideChat(
                                        chatRoom: chatRoomModel,
                                        targetUser: targetUser,
                                        user: userModel!,
                                        firebaseUser: firebaseUser!,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05,
                                            vertical: size.height * 0.01),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: const NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScuQGyYbgV9HFyiunO9mF6_lnB6MYwcx6t3w&usqp=CAU"),
                                              radius: size.width * 0.08,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.05,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  targetUser!.firstName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: size.height * 0.01),
                                                SizedBox(
                                                  width: size.width * 0.5,
                                                  child: (chatRoomModel
                                                              .lastMessage
                                                              .toString() !=
                                                          "")
                                                      ? Text(
                                                          chatRoomModel
                                                              .lastMessage
                                                              .toString(),
                                                          softWrap: false,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: AppColors()
                                                                .darKShadowColor,
                                                            fontSize: 16.0,
                                                          ),
                                                        )
                                                      : Text(
                                                          "Start a conversation",
                                                          softWrap: false,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: AppColors()
                                                                .primaryColor,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Text(
                                              (dateTime.year == now.year &&
                                                      dateTime.month ==
                                                          now.month &&
                                                      dateTime.day == now.day)
                                                  ? formattedTime
                                                  : formattedDate,
                                              style: TextStyle(
                                                color:
                                                    AppColors().darKShadowColor,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppColors().lightShadowColor,
                                        thickness: 1,
                                        indent: size.width * 0.2,
                                        endIndent: size.width * 0.1,
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Container(),
                                );
                              }
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    );
                  } else if (snap.hasError) {
                    return Center(
                      child: Text(snap.error.toString()),
                    );
                  } else if (snap.hasData == false) {
                    return const Center(
                      child: Text("no chats"),
                    );
                  } else {
                    return const Center(
                      child: Text("no chats"),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
