import 'package:coachingapp/widgets/large_button_trasparent_text_left_align.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';
import 'auth/login.dart';

class CoachProfile extends StatefulWidget {
  const CoachProfile({Key? key}) : super(key: key);

  @override
  State<CoachProfile> createState() => _CoachProfileState();
}

class _CoachProfileState extends State<CoachProfile> {
  String finalKey = '';
  // String finalEmail = '';
  @override
  void initState() {
    super.initState();
    getValidationKey();
    print(finalKey);
    // _getUserType().then((userType) {
    //   setState(() {
    //     _userType = userType!;
    //   });
    // });
  }

  Future getValidationKey() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedKey = sharedPreferences.getString('key');
    // var obtainedEmail = sharedPreferences.getString('email');

    setState(() {
      finalKey = obtainedKey!;
      // finalEmail = obtainedEmail!;
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Profile',
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
                                backgroundImage: AssetImage('assets/img.png'),
                              ),
                            ),
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
                            'coach',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors().darKShadowColor,
                            ),
                          ),
                          Text(
                            'johnsmith12@gmail.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors().darKShadowColor,
                            ),
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "My Account",
                            onPressed: () {},
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "My Program",
                            onPressed: () {},
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "My Tracking",
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "Help Center",
                            onPressed: () {},
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "Privacy Policy",
                            onPressed: () {},
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "Terms and Services",
                            onPressed: () {},
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: AppColors().darKShadowColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try{
                                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                    sharedPreferences.remove('key');
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClientLogin()));
                                  }catch(e){
                                    print(e.toString());
                                  }

                                },
                                child: Text(
                                  "Log Out",
                                  style: TextStyle(
                                      color: AppColors().darKShadowColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          )
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
