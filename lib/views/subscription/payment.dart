import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';


class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "\$2,000",
                          style: TextStyle(
                            color: Color(0xff06279e),
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(width: screenWidth*0.1,),
                        const Text(
                          "+ VAT",
                          style: TextStyle(
                            color: Color(0xff919191),
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                      child: DottedLine(
                        dashColor: Colors.green.shade200,
                        dashGapLength: 4.0,
                        dashLength: 4.0,
                        lineThickness: 2.0,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select payment method",
                        style: TextStyle(
                          color: Color(0xff05269e),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children:[
                    Container(
                      width: double.infinity,
                      height: screenHeight*0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffe5e5e5), width: 1, ),
                        color: const Color(0xfff1f3f6),
                      ),
                      padding: const EdgeInsets.only(left: 23, right: 28, ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            width: 41,
                            height: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffe6e9f5),
                            ),
                          ),
                          const Text(
                            "Paypal",
                            style: TextStyle(
                              color: Color(0xff25282b),
                              fontSize: 16,
                            ),
                          ),
                          const FlutterLogo(size: 22),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                      child: Container(
                        width: double.infinity,
                        height: screenHeight*0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffe5e5e5), width: 1, ),
                          color: const Color(0xfff1f3f6),
                        ),
                        padding: const EdgeInsets.only(left: 23, right: 28, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Container(
                              width: 41,
                              height: 41,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffe6e9f5),
                              ),
                            ),
                            const Text(
                              "Stripe",
                              style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 16,
                              ),
                            ),
                            const FlutterLogo(size: 22),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: screenHeight*0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffe5e5e5), width: 1, ),
                        color: const Color(0xfff1f3f6),
                      ),
                      padding: const EdgeInsets.only(left: 23, right: 28, ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            width: 41,
                            height: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffe6e9f5),
                            ),
                          ),
                          const Text(
                            "Bank wire",
                            style: TextStyle(
                              color: Color(0xff25282b),
                              fontSize: 16,
                            ),
                          ),
                          const FlutterLogo(size: 22),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Payment()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: screenHeight*0.05,
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
      )
    );
  }
}
