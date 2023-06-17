import 'package:coachingapp/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'navscreens/chat/chat_list.dart';
import 'navscreens/coachfind.dart';
import 'navscreens/notification.dart';
import 'navscreens/profile.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({Key? key}) : super(key: key);

  @override
  State<ClientHome> createState() => _HomeClientState();
}

class _HomeClientState extends State<ClientHome> {
  int currentTab = 0;

  final List<Widget> screens = [
    const CoachFind(),
    const ClientNotification(),
    const ChatList(),
    const Profile(),
  ];

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const CoachFind();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors().primaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.calendar_month_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: SizedBox(
          height: screenHeight * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const CoachFind();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.feed,
                          size: 30,
                          color: currentTab == 0
                              ? AppColors().primaryColor
                              : Colors.grey,
                        ),
                        // Text(
                        //   'Dashboard',
                        //   style: TextStyle(
                        //       color:
                        //       currentTab == 0 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ClientNotification();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          size: 35,
                          color: currentTab == 1
                              ? AppColors().primaryColor
                              : Colors.grey,
                        ),
                        // Text(
                        //   'Chat',
                        //   style: TextStyle(
                        //       color:
                        //       currentTab == 1 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ChatList();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble,
                          size: 35,
                          color: currentTab == 2
                              ? AppColors().primaryColor
                              : Colors.grey,
                        ),
                        // Text(
                        //   'Profile',
                        //   style: TextStyle(
                        //       color:
                        //       currentTab == 2 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_sharp,
                          size: 35,
                          color: currentTab == 3
                              ? AppColors().primaryColor
                              : Colors.grey,
                        ),
                        // Text(
                        //   'Settings',
                        //   style: TextStyle(
                        //       color:
                        //       currentTab == 3 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
