import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({Key? key}) : super(key: key);

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth*0.05),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight*0.02,bottom: screenHeight*0.02),
                  child: CircleAvatar(
                    radius: screenWidth*0.15,
                    backgroundColor: AppColors().primaryColor,
                    child: CircleAvatar(
                      radius: screenWidth*0.145,
                      backgroundImage: const AssetImage('assets/img.png'),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 12.0,
                          child: Icon(
                            Icons.camera_alt,
                            size:screenWidth*0.06,
                            color: AppColors().darKShadowColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Text("William Sey",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                Text("Professional Fitness Trainer",style: TextStyle(fontSize: 16,color: AppColors().primaryColor),),
                GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight*0.01,horizontal: screenWidth*0.1),
                  width: double.infinity,
                  height: screenHeight * 0.055,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors().primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text(
                    "Message",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
                const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("Followers"),
                        Text("2541",style: TextStyle(fontSize: 28),),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Experince"),
                        Text("1 year +",style: TextStyle(fontSize: 28),),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Projects"),
                        Text("241",style: TextStyle(fontSize: 28),),
                      ],
                    ),

                  ],
                ),
              ) ,
                Expanded(
                  child: GridView.builder(
                    itemCount: 100,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // height: 200,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/img.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
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
