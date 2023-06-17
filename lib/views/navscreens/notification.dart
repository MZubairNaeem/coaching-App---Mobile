// ignore_for_file: unused_result

import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/views/navscreens/schedule/playvideos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/get_schedule_notification.dart';

class ClientNotification extends StatefulWidget {
  const ClientNotification({Key? key}) : super(key: key);

  @override
  State<ClientNotification> createState() => _ClientNotificationState();
}

class _ClientNotificationState extends State<ClientNotification> {
  bool Today = false;
  bool Yesterday = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Notification",
          style: TextStyle(color: AppColors().darKShadowColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.1),
        child: Stack(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final notification = ref.watch(NotificationProvider);
                ref.refresh(NotificationProvider);
                return notification.when(
                  data: (notification) {
                    notification.isEmpty
                        ? Center(
                            child: Text(
                              "No Notification",
                              style: TextStyle(
                                color: AppColors().darKShadowColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container();
                    return ListView.builder(
                      itemCount: notification.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: screenHeight * 0.02,
                              left: screenWidth * 0.02,
                              right: screenWidth * 0.02),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayVideo(
                                            videoIDs:
                                                notification[index].videos!,
                                          )));
                            },
                            child: Column(
                              children: [
                                //Show Today or Yesterday or date of the schedule using creadted_at
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.09),
                                      child: Text(
                                        getDateFormat(notification[index]
                                            .created_at!
                                            .toDate()),
                                        style: TextStyle(
                                          color: AppColors().primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.1,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors().primaryColor),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.all(screenWidth * 0.005),
                                        child: Container(
                                          height: screenHeight * 0.095,
                                          width: screenWidth * 0.22,
                                          decoration: BoxDecoration(
                                            color: AppColors().lightShadowColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(50.0),
                                              bottomLeft: Radius.circular(50.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: screenWidth * 0.1),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FutureBuilder<String>(
                                              future: getSchuduleTitle(
                                                  notification[index]
                                                      .scheduleId!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    snapshot.data!,
                                                    style: TextStyle(
                                                      color: AppColors()
                                                          .primaryColor,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      'Error retrieving schedule title');
                                                } else {
                                                  return Text('Loading...');
                                                }
                                              },
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.watch_later_outlined,
                                                  color: AppColors()
                                                      .lightShadowColor,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.01,
                                                ),
                                                //Show the date not time of the schedule
                                                Text(
                                                  notification[index]
                                                      .assignDate!
                                                      .toDate()
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColors()
                                                        .darKShadowColor,
                                                    fontSize: 8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                //Time of the schedule
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${notification[index].created_at!.toDate().hour}:${notification[index].created_at!.toDate().minute} ${notification[index].created_at!.toDate().hour > 12 ? "PM" : "AM"}",
                                    style: TextStyle(
                                      color: AppColors().darKShadowColor,
                                      fontSize: 8,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Text("..."),
                  error: (error, stackTrace) => Text('Error: $error'),
                );
                //ref.refresh(notification);
              },
            ),
          ],
        ),
      ),
    );
  }

  String getDateFormat(DateTime date) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return "Today";
    } else if (date.day == yesterday.day &&
        date.month == yesterday.month &&
        date.year == yesterday.year) {
      return "Yesterday";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }
}
