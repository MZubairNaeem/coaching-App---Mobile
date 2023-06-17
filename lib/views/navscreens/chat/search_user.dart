import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/main.dart';
import 'package:coachingapp/models/user.dart';
import 'package:coachingapp/models/chat_room_model.dart';
import 'package:coachingapp/widgets/large_button_blue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import 'chat.dart';

class SearchUser extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const SearchUser(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final currentuser = FirebaseAuth.instance.currentUser;
  }

  final searchController = TextEditingController();

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participant.${widget.userModel.uid}", isEqualTo: true)
        .where("participant.${targetUser.uid}", isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      var docData = snapshot.docs.first.data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatRoom;
      print("chat room found");
    } else {
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        lastMessageTime: Timestamp.now(),
        participant: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        users: [widget.userModel.uid.toString(), targetUser.uid.toString()],
      );
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.chatroomid)
          .set(
            newChatroom.toMap(),
          );
      chatRoom = newChatroom;
      print("chat room created");
    }
    return chatRoom;
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
            "Search",
            style: TextStyle(color: AppColors().darKShadowColor),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  fillColor: AppColors().darKShadowColor,
                  focusColor: AppColors().primaryColor,
                  hintStyle: TextStyle(color: AppColors().darKShadowColor),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors().darKShadowColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors().primaryColor, width: 2.0),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              LargeButton(
                  name: "Search",
                  onPressed: () {
                    setState(() {});
                  }),
              SizedBox(
                height: size.height * 0.05,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .where('firstName',
                        isGreaterThanOrEqualTo: searchController.text.trim())
                    .where("firstName",
                        isNotEqualTo: widget.userModel.firstName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot? dataSnapshot = snapshot.data;
                      if (dataSnapshot!.docs.isNotEmpty) {
                        Map<String, dynamic>? userMap = dataSnapshot.docs.first
                            .data() as Map<String, dynamic>?;
                        UserModel searchUser = UserModel.fromMap(userMap!);
                        return Card(
                          elevation: 2,
                          shadowColor: AppColors().primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            onTap: () async {
                              ChatRoomModel? chatRoomModel =
                                  await getChatRoomModel(searchUser);
                              if (chatRoomModel != null) {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClientSideChat(
                                            targetUser: searchUser,
                                            chatRoom: chatRoomModel,
                                            user: widget.userModel,
                                            firebaseUser:
                                                widget.firebaseUser)));
                              }
                            },
                            title: Text(searchUser.firstName),
                            subtitle: Text(searchUser.email),
                            trailing: const Icon(Icons.message),
                          ),
                        );
                      } else {
                        return const Center(child: Text("No Results Found"));
                      }
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("An Error Occured"));
                    } else {
                      return const Center(child: Text("No Results Found"));
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
