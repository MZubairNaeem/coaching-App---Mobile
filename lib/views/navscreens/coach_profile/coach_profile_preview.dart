import 'package:coachingapp/views/navscreens/coach_profile/upload_video_by_coach.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/get_user_type.dart';
import '../../../utils/colors.dart';

class CoachProfilePreview extends StatefulWidget {
  const CoachProfilePreview({Key? key}) : super(key: key);

  @override
  State<CoachProfilePreview> createState() => _CoachProfilePreviewState();
}

class _CoachProfilePreviewState extends State<CoachProfilePreview> {
  @override
  Widget build(BuildContext context) {
    
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: CircleAvatar(
              // radius: 5,
              backgroundImage: AssetImage('assets/img.png'),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style:
                    TextStyle(color: AppColors().darKShadowColor, fontSize: 16),
              ),
              Consumer(
                builder: (context, ref, _) {
                  final userResult = ref.read(userProvider);
                  return userResult.when(
                    data: (userModel) {
                      return Text(
                        userModel.firstName,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors().darKShadowColor,
                        ),
                      );
                    },
                    loading: () => Text("..."),
                    error: (error, stackTrace) => Text('Error: $error'),
                  );
                },
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.1),
              child: Icon(
                Icons.notifications_none_outlined,
                color: AppColors().darKShadowColor,
                size: 28,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: screenHeight * 0.14,
                  child: Column(
                    children: [
                      const Text(
                        "Want to Upload Short Video?",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UploadVideo()));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.25,
                              vertical: screenHeight * 0.02),
                          width: double.infinity,
                          height: screenHeight * 0.055,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors().primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: const Text(
                            "Upload Videos",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/img.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/img.png'),
                                  ),
                                  Text(
                                    'My Name',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                }),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
