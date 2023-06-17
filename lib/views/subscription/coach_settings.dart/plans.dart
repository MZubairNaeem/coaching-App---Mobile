import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../widgets/custom_background.dart';

class PlanDescription extends StatefulWidget {
  const PlanDescription({super.key});

  @override
  State<PlanDescription> createState() => _PlanDescriptionState();
}

class _PlanDescriptionState extends State<PlanDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipperPath(),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors().primaryColor,
              ),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Subscrition Plans",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Here are your plans",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
