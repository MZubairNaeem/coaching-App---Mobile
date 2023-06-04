import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/views/navscreens/chat/search_user.dart';
import 'package:flutter/material.dart';
import 'clientchat.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: false,
              backgroundColor: Colors.transparent,
              title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchUser()));
                  },
                  child: Container(
                    height: screenHeight * 0.06,
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
                  )),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ClientSideChat())),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: const NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScuQGyYbgV9HFyiunO9mF6_lnB6MYwcx6t3w&usqp=CAU"),
                                radius: screenWidth * 0.08,
                              ),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Adam John",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  SizedBox(
                                    width: screenWidth * 0.5,
                                    child: Text(
                                      "hello! my name is adam john and i'm your new tariner",
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors().darKShadowColor,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                "10:30pm",
                                style: TextStyle(
                                  color: AppColors().darKShadowColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: AppColors().lightShadowColor,
                        thickness: 1,
                        indent: screenWidth * 0.2,
                        endIndent: screenWidth * 0.1,
                      )
                    ],
                  );
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
