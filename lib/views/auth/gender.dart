import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/widgets/large_button_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CoachGender extends StatefulWidget {
  const CoachGender({Key? key}) : super(key: key);

  @override
  State<CoachGender> createState() => _CoachGenderState();
}

class _CoachGenderState extends State<CoachGender> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/fitnesslogo.svg',
                          alignment: Alignment.topCenter),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'FITNESS',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
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
              child: Container(
                height: MediaQuery.of(context).size.height / 1.38,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(50))),
                child: Padding(
                  padding: EdgeInsets.all(screenHeight * 0.035),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors().primaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            // margin: EdgeInsets.symmetric(),
                            width: double.infinity,
                            height: screenHeight * 0.075,
                            alignment: Alignment.center,
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
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Text(
                              'Male',
                              style: TextStyle(color: AppColors().primaryColor, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            // margin: EdgeInsets.symmetric(),
                            width: double.infinity,
                            height: screenHeight * 0.075,
                            alignment: Alignment.center,
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
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Text(
                              'Female',
                              style: TextStyle(color: AppColors().primaryColor, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            // margin: EdgeInsets.symmetric(),
                            width: double.infinity,
                            height: screenHeight * 0.075,
                            alignment: Alignment.center,
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
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Text(
                              'Other',
                              style: TextStyle(color: AppColors().primaryColor, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight*0.09),
                        child: const LargeButton(
                          name: 'Sign Up',
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
