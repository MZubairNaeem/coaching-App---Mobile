// ignore_for_file: use_build_context_synchronously

import 'package:coachingapp/models/Schedule.dart';
import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/viewmodels/scheduleViewModel.dart';
import 'package:coachingapp/views/navscreens/schedule/newroutine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/large_button_blue.dart';
import '../../../widgets/snackbar.dart';

class WorkOutPlan extends StatelessWidget {
  const WorkOutPlan({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().whiteColor,
        leading: Icon(
          Icons.arrow_back,
          color: AppColors().blackColor.withOpacity(0.5),
          size: MediaQuery.of(context).size.width * 0.08,
        ),
        title: Text("Add Workout Plan",
            style: TextStyle(
                color: AppColors().blackColor.withOpacity(0.5),
                fontSize: MediaQuery.of(context).size.width * 0.04)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors().blackColor.withOpacity(0.6))),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 1,
                          color: AppColors().lightShadowColor), //<-- SEE HERE
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 1, color: AppColors().lightShadowColor),
                    ),
                    hintText: 'Add a title eg: Warm up',
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Description",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors().blackColor.withOpacity(0.6))),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 1,
                          color: AppColors().lightShadowColor), //<-- SEE HERE
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 1, color: AppColors().lightShadowColor),
                    ),
                    hintText: 'What training are you doing',
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
              const SizedBox(
                height: 70,
              ),
              LargeButton(
                name: "Save",
                onPressed: () async {
                  if (titleController.value.text.isNotEmpty &&
                      descriptionController.value.text.isNotEmpty) {
                    Schedule schedule = Schedule(
                        CoachId: FirebaseAuth.instance.currentUser!.uid,
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text,
                        description: descriptionController.text);
                    String result =
                        await SchduleViewModel().AddSchedule(schedule);
                    if (result == "Success") {
                      showSnackBar(context, "Schedule Added Successfully");
                      //Navigate screen back and refresh and pop the current screen
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewRoutine()));
                    } else {
                      showSnackBar(context, "Schedule Added Failed");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
