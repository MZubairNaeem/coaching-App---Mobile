import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/views/subscription/basicplan.dart';
import 'package:coachingapp/views/subscription/comprehensiveplan.dart';
import 'package:coachingapp/views/subscription/executiveplan.dart';
import 'package:flutter/material.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.05, horizontal: screenWidth * 0.08),
            child: Column(
              children: [
                const Text(
                  "Subscriptions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const BasicPlan()));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                    width: double.infinity,
                    height: screenHeight * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: screenWidth*0.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Basic",
                                style: TextStyle(
                                  color: AppColors().primaryColor,
                                  fontSize: 24,
                                ),
                              ),
                              Container(
                                width: screenWidth*0.2,
                                height: screenHeight*0.03,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "\$1'000/m",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Icon(
                            Icons.chevron_right_sharp,
                            color: AppColors().darKShadowColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ExecutivePlan()));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                    width: double.infinity,
                    height: screenHeight * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: screenWidth*0.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Executive",
                                style: TextStyle(
                                  color: AppColors().primaryColor,
                                  fontSize: 24,
                                ),
                              ),
                              Container(
                                width: screenWidth*0.2,
                                height: screenHeight*0.03,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "\$1'500/m",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Icon(
                            Icons.chevron_right_sharp,
                            color: AppColors().darKShadowColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ComprehensivePlan()));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                    width: double.infinity,
                    height: screenHeight * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: screenWidth*0.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Comprehensive",
                                style: TextStyle(
                                  color: AppColors().primaryColor,
                                  fontSize: 24,
                                ),
                              ),
                              Container(
                                width: screenWidth*0.2,
                                height: screenHeight*0.03,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "\$2'000/m",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Icon(
                            Icons.chevron_right_sharp,
                            color: AppColors().darKShadowColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
