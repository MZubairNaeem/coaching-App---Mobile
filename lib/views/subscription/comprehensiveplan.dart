import 'package:coachingapp/views/subscription/payment.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class ComprehensivePlan extends StatelessWidget {
  const ComprehensivePlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight*0.1,horizontal: screenWidth*0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              Column(
                children: [
                  const Text(
                    "Comprehensive",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff05269e),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: screenHeight*0.02,),
                  Container(
                    width: screenWidth*0.2,
                    height: screenHeight*0.03,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
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
              DottedLine(
                dashColor: Colors.green.shade200,
                dashGapLength: 4.0,
                dashLength: 4.0,
                lineThickness: 2.0,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xff05269e), width: 1, ),
                          color: const Color(0x7f7f3a44),
                        ),
                      ),
                      const Text(
                        "Unlimited trainers consultation 24/7 for a month",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xff05269e), width: 1, ),
                          color: const Color(0x7f7f3a44),
                        ),
                      ),
                      const Text(
                        "Instructor led online fitness gym",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xff05269e), width: 1, ),
                          color: const Color(0x7f7f3a44),
                        ),
                      ),
                      const Text(
                        "Instructor led online fitness gym",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff28b446),
                        ),
                      ),
                      const Text(
                        "Instructor led online fitness gym",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff28b446),
                        ),
                      ),
                      const Text(
                        "Instructor led online fitness gym",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff28b446),
                        ),
                      ),
                      const Text(
                        "Instructor led online fitness gym",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff28b446),
                        ),
                      ),
                      const Text(
                        "Instructor led online fitness gym",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
                ],
              ),
              DottedLine(
                dashColor: Colors.green.shade200,
                dashGapLength: 4.0,
                dashLength: 4.0,
                lineThickness: 2.0,
              ),

              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const Payment())),
                child: Container(
                  width: 305,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff05269e),
                  ),
                  child: const Center(
                    child: Text(
                      "Subscribe to this plan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
