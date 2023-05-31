import 'package:coachingapp/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../widgets/large_button_blue.dart';


class WorkOutPlan extends StatelessWidget {
  const WorkOutPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            const LargeButton(
              name: "Save",
            ),
          ],
        ),
      ),
    );
  }
}
