import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/views/navscreens/schedule/playvideos.dart';
import 'package:flutter/material.dart';

class ClientNotification extends StatefulWidget {
  const ClientNotification({Key? key}) : super(key: key);

  @override
  State<ClientNotification> createState() => _ClientNotificationState();
}

class _ClientNotificationState extends State<ClientNotification> {
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
      // body: Padding(
      //   padding: EdgeInsets.all(screenWidth*0.1),
      //   child: Container(
      //     height: screenHeight*0.1,
      //     width: double.infinity,
      //     decoration: BoxDecoration(
      //       border: Border.all(color: AppColors().primaryColor),
      //       borderRadius: BorderRadius.circular(50.0),
      //     ),
      //     child:Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Container(
      //           decoration: BoxDecoration(
      //
      //             borderRadius: BorderRadius.horizontal(left: Radius.circular(50))
      //           ),
      //         )
      //       ],
      //     )
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.1),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlayVideos()));
              },
              child: Container(
                height: screenHeight * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors().primaryColor),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.005),
                      child: Container(
                        height: screenHeight * 0.095,
                        width: screenWidth * 0.22,
                        decoration: BoxDecoration(
                          color: AppColors().lightShadowColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Squat",
                            style: TextStyle(
                                color: AppColors().primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: AppColors().lightShadowColor,
                              ),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                              Text(
                                "10 min",
                                style: TextStyle(
                                    color: AppColors().darKShadowColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: screenWidth*0.05),
                    //   child: Icon(Icons.notifications,size: screenWidth*0.1,color: AppColors().primaryColor,),
                    // )
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.05),
                      child: Container(
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors().primaryColor,
                          // borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       height: screenHeight * 0.095,
            //       width: screenWidth*0.22,
            //       decoration: BoxDecoration(
            //         color: AppColors().lightShadowColor,
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(50.0),
            //           bottomLeft: Radius.circular(50.0),
            //         ),
            //       ),
            //     ),
            //     Column(
            //       children: [
            //         Text("Squat"),
            //         Row(
            //           children: [
            //             Icon(Icons.watch_later_outlined),
            //             Text("10 min"),
            //           ],
            //         ),
            //       ],
            //     ),
            //     Icon(Icons.notifications,size: screenWidth*0.1,color: AppColors().primaryColor,)
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
