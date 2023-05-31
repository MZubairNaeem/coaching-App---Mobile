import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/large_button_trasparent_text_left_align.dart';


class CoachAccount extends StatefulWidget {
  const CoachAccount({Key? key}) : super(key: key);

  @override
  State<CoachAccount> createState() => _CoachAccountState();
}

class _CoachAccountState extends State<CoachAccount> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.6,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3.6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors().primaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'My Account',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 47.0,
                                backgroundImage: const AssetImage('assets/img.png'),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 12.0,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 15.0,
                                      color: AppColors().darKShadowColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'Upload your photo',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.38,
                decoration: BoxDecoration(color: AppColors().primaryColor),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.38,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50))),
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight * 0.035),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'johnsmith12@gmail.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors().darKShadowColor,
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.3,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: const BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("First name"),
                                      Text("John"),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors().lightShadowColor,
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Phone number"),
                                      Text("0628120101"),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors().lightShadowColor,
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Date of birth"),
                                      Text("31-05-2001"),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors().lightShadowColor,
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Location"),
                                      Text("USA"),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors().lightShadowColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight*0.005,
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "Change Password",
                            onPressed: () {},
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "Settings",
                            onPressed: () {},
                          ),
                        ],
                      ),
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
