import 'package:chewie/chewie.dart';
import 'package:coachingapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../models/videos.dart';
import '../../../providers/get_demoVideos.dart';

// final videoListProvider = FutureProvider<List<Video>>((ref) async {
//   QuerySnapshot videoSnapshot =
//       await FirebaseFirestore.instance.collection('Videos').get();

//   return videoSnapshot.docs.map((doc) {
//     return Video(
//       videoUrl: doc['videoUrl'],
//       videoTitle: doc['videoTitle'],
//       videoDescription: doc['videoDescription'],
//       videoId: 'videoId',
//       videoThumbnail: doc['videoThumbnail'],
//     );
//   }).toList();
// });

class PlayVideo extends StatefulWidget {
  final List videoIDs;
  const PlayVideo({super.key, required this.videoIDs});

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  @override
  Widget build(BuildContext context) {
    final VideoLists = StreamProvider<List<Video>>(
      (ref) => getScheduleVideos(widget.videoIDs),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
        title: const Text(
          "Play Videos",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final videoList = ref.watch(VideoLists);
                ref.refresh(VideoLists);
                return videoList.when(
                  data: (videoList) {
                    return VideoPlayerWidget(videoList: videoList);
                  },
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
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final List<Video> videoList;

  const VideoPlayerWidget({super.key, required this.videoList});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  int selectedVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _initPlayer(selectedVideoIndex);
  }

  void _initPlayer(int index) {
    final video = widget.videoList[index];
    videoPlayerController = VideoPlayerController.network("${video.videoUrl}");
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors().primaryColor,
        handleColor: AppColors().primaryColor,
        backgroundColor: AppColors().primaryColor.withOpacity(0.5),
        bufferedColor: AppColors().primaryColor.withOpacity(0.5),
      ),
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Chewie(
            controller: chewieController,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.videoList.length,
          itemBuilder: (context, index) {
            final video = widget.videoList[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedVideoIndex = index;
                  videoPlayerController.pause();
                  videoPlayerController.dispose();

                  chewieController.pause();
                  chewieController.dispose();

                  _initPlayer(selectedVideoIndex);
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors().blackColor.withOpacity(0.1),
                ),
                child: ListTile(
                  // leading: Container(
                  //   height: 50,
                  //   width: 50,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: AppColors().blackColor.withOpacity(0.1),
                  //     image: DecorationImage(
                  //       image: NetworkImage('${video.videoThumbnail}'),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  title: Text(
                    '${video.videoTitle}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${video.videoDescription}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    Icons.play_circle_outline,
                    color: AppColors().primaryColor,
                    size: 30,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
