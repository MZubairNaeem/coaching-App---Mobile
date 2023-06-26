import 'package:coachingapp/views/navscreens/coach_profile/upload_video_by_coach.dart';
import 'package:coachingapp/views/subscription/coach_app_subscription/coach_app_sub.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/coach_app_sub.dart';
import '../../../models/videos.dart';
import '../../../providers/firebase_helper.dart';
import '../../../providers/get_demoVideos.dart';
import '../../../providers/get_user_type.dart';
import '../../../utils/colors.dart';
import '../../../widgets/demo_video_player.dart';

class CoachProfilePreview extends StatefulWidget {
  const CoachProfilePreview({Key? key}) : super(key: key);

  @override
  State<CoachProfilePreview> createState() => _CoachProfilePreviewState();
}

class _CoachProfilePreviewState extends State<CoachProfilePreview> {
  CoachAppSubModel? coachAppSubData;
  @override
  void initState() {
    getStarted();
    super.initState();
  }

  CoachAppSubModel? coachAppSubModel;
  Future<CoachAppSubModel> getCoachAppSubData(String uid) async {
    CoachAppSubModel coachAppSub =
        await FirebaseHelper.getCoachSubModelById(uid);
      coachAppSubModel = coachAppSub;
    return coachAppSub;
  }

  Future<void> getStarted() async {
    coachAppSubData =
        await getCoachAppSubData(FirebaseAuth.instance.currentUser!.uid);
    if (coachAppSubData!.status != "active") {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CoachAppSub()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final demoVideosProvider = StreamProvider<List<Video>>(
      (ref) => getVideosStream(FirebaseAuth.instance.currentUser!.uid),
    );
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Alert",
                style: TextStyle(
                    color: AppColors().primaryColor,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
              content: Text("Are you sure you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    "Yes",
                    style: TextStyle(color: AppColors().primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "No",
                    style: TextStyle(color: AppColors().primaryColor),
                  ),
                ),
              ],
            ),
          );
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Consumer(
                builder: (context, ref, _) {
                  final userResult = ref.watch(userProvider);
                  return userResult.when(
                    data: (userModel) {
                      return CircleAvatar(
                        // radius: 5,
                        backgroundImage: NetworkImage(userModel.photoUrl),
                      );
                    },
                    loading: () => const Text("..."),
                    error: (error, stackTrace) => Text('Error: $error'),
                  );
                },
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: AppColors().darKShadowColor, fontSize: 16),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final userResult = ref.watch(userProvider);
                    ref.refresh(userProvider);
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
                      loading: () => const Text("..."),
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
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                children: [
                  Column(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer(
                    builder: (context, ref, __) {
                      final videos = ref.watch(demoVideosProvider);
                      ref.refresh(demoVideosProvider);
                      return videos.when(
                        data: (videos) => Expanded(
                          child: GridView.builder(
                            itemCount: videos.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.grey[300],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        videos[index].videoThumbnail!,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DemoVideoPlayer(
                                          VideoURL: videos[index].videoUrl!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        color: AppColors()
                                            .whiteColor
                                            .withOpacity(0.8),
                                        child: Center(
                                          child: Text(
                                            videos[index].videoTitle!,
                                            style: TextStyle(
                                              color: AppColors().primaryColor,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stackTrace) => Center(
                          child: Text(error.toString()),
                        ),
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
