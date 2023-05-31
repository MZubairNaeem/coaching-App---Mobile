import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../widgets/calender_widget.dart';
import '../../../widgets/custom_background.dart';


class NewRoutine extends StatefulWidget {
  const NewRoutine({super.key});

  @override
  State<NewRoutine> createState() => _NewRoutineState();
}

class _NewRoutineState extends State<NewRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipperPath(),
            child: Container(
                padding: const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                  color: AppColors().primaryColor,
                ),
                height: MediaQuery.of(context).size.height * 0.48,
                child: const Calender()),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                padding: const EdgeInsets.only(top: 230.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: AppColors().whiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors().blackColor.withOpacity(0.2),
                            blurRadius: 10.0,
                            spreadRadius: 5.0)
                      ]),
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Icon(
                            Icons.search,
                            color: AppColors().darKShadowColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  AppColors().lightShadowColor), //<-- SEE HERE
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              width: 1, color: AppColors().lightShadowColor),
                        ),
                        hintText: 'Type Searching',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                )),
          ),
          Positioned(
              top: 380.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 90.0, bottom: 20.0),
                      child: Text("Today's Routine",
                          style: TextStyle(
                              color: AppColors().blackColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300)),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.87,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: AppColors().whiteColor.withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppColors().blackColor.withOpacity(0.1),
                                  blurRadius: 10.0,
                                  spreadRadius: 5.0)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, top: 20.0, bottom: 20.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Warm Up",
                                style: TextStyle(
                                    color: AppColors().primaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      BoxShadow(
                                          color: AppColors()
                                              .blackColor
                                              .withOpacity(0.1),
                                          blurRadius: 10.0,
                                          spreadRadius: 5.0)
                                    ]),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: Colors.black45),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text("12 Min")
                                ],
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.87,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: AppColors().whiteColor.withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppColors().blackColor.withOpacity(0.1),
                                  blurRadius: 10.0,
                                  spreadRadius: 5.0)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, top: 20.0, bottom: 20.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Squat",
                                style: TextStyle(
                                    color: AppColors().primaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      BoxShadow(
                                          color: AppColors()
                                              .blackColor
                                              .withOpacity(0.1),
                                          blurRadius: 10.0,
                                          spreadRadius: 5.0)
                                    ]),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: Colors.black45),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text("12 Min")
                                ],
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.87,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: AppColors().whiteColor.withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppColors().blackColor.withOpacity(0.1),
                                  blurRadius: 10.0,
                                  spreadRadius: 5.0)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, top: 20.0, bottom: 20.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Step Ups",
                                style: TextStyle(
                                    color: AppColors().primaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      BoxShadow(
                                          color: AppColors()
                                              .blackColor
                                              .withOpacity(0.1),
                                          blurRadius: 10.0,
                                          spreadRadius: 5.0)
                                    ]),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: Colors.black45),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text("12 Min")
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
