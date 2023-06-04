import 'package:coachingapp/models/user.dart';
import 'package:coachingapp/viewmodels/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/videos.dart';
import '../providers/get_demoVideos.dart';
import '../utils/colors.dart';
import '../widgets/demo_video_player.dart';

class PublicProfile extends StatefulWidget {
  final UserModel userModel;
  const PublicProfile({Key? key, required this.userModel}) : super(key: key);

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final demoVideosProvider = StreamProvider<List<Video>>(
      (ref) => getVideosStream(widget.userModel.uid),
    );
    final subscriptionProvider = FutureProvider<bool>((ref) async {
      final uid = widget.userModel.uid;
      final subscribed = await Auth().checkSubscription(uid);
      return subscribed;
    });

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                child: CircleAvatar(
                  radius: screenWidth * 0.15,
                  backgroundColor: AppColors().primaryColor,
                  child: CircleAvatar(
                    radius: screenWidth * 0.145,
                    backgroundImage: const AssetImage('assets/img.png'),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 12.0,
                        child: Consumer(
                          builder: (context, ref, __) {
                            final subscriptionStatus =
                                ref.watch(subscriptionProvider);

                            return subscriptionStatus.maybeWhen(
                              data: (subscribed) => subscribed
                                  ? Icon(Icons.check)
                                  : GestureDetector(
                                      onTap: () {
                                        Auth().Subscirbe(widget.userModel.uid);
                                        ref.refresh(subscriptionProvider);
                                      },
                                      child: Icon(Icons.add),
                                    ),
                              orElse: () => CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                widget.userModel.firstName,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                "Professional Fitness Trainer",
                style: TextStyle(fontSize: 16, color: AppColors().primaryColor),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.1),
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
                        Text(
                          "2541",
                          style: TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Experince"),
                        Text(
                          "1 year +",
                          style: TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Projects"),
                        Text(
                          "241",
                          style: TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, __) {
                  final videos = ref.watch(demoVideosProvider);

                  print(videos);
                  return videos.maybeWhen(
                    data: (videos) => Expanded(
                      child: GridView.builder(
                        itemCount: videos.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
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
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: AppColors().primaryColor,
                                size: 40,
                              ),
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
                    orElse: () => const Center(
                      child: Text("No Videos"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
