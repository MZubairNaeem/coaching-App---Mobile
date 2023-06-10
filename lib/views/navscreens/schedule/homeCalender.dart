import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/views/navscreens/schedule/newroutine.dart';
import 'package:coachingapp/views/navscreens/schedule/workout_plan.dart';
import 'package:flutter/material.dart';

import '../../../widgets/calender_widget.dart';
import '../../../widgets/custom_background.dart';
import '../../../widgets/large_button_blue.dart';

class HomeCalender extends StatefulWidget {
  const HomeCalender({super.key});

  @override
  State<HomeCalender> createState() => _HomeCalenderState();
}

class _HomeCalenderState extends State<HomeCalender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipperPath(),
            child: Container(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                  color: AppColors().primaryColor,
                ),
                height: MediaQuery.of(context).size.height * 0.4,
                child: const Calender()),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Need a rest?",
                    style: TextStyle(
                      color: AppColors().blackColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text("You Don't have anything",
                      style: TextStyle(
                        color: AppColors().blackColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      )),
                  Text(
                    "scheduled for today",
                    style: TextStyle(
                      color: AppColors().blackColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: LargeButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewRoutine()));
                      },
                      name: 'Scheduled Now',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
