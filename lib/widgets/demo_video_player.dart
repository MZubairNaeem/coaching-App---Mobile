import 'package:coachingapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DemoVideoPlayer extends StatefulWidget {
  final VideoURL;
  const DemoVideoPlayer({super.key, required this.VideoURL});

  @override
  State<DemoVideoPlayer> createState() => _DemoVideoPlayerState();
}

class _DemoVideoPlayerState extends State<DemoVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.VideoURL,
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
    )..initialize().then((_) {
        setState(() {
          _controller.setLooping(true);
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height,
          child: VideoPlayer(_controller),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            },
            child: ValueListenableBuilder<VideoPlayerValue>(
              valueListenable: _controller,
              builder: (BuildContext context, VideoPlayerValue value,
                  Widget? child) {
                return value.isBuffering
                    ? const CircularProgressIndicator()
                    : Icon(
                        value.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 50,
                      );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width: double.infinity,
            color: Colors.black54,
            child: VideoProgressIndicator(_controller,
                allowScrubbing: true,
                padding: const EdgeInsets.all(10.0),
                colors: VideoProgressColors(
                  playedColor: AppColors().primaryColor,
                  bufferedColor: AppColors().senderColor,
                  backgroundColor: AppColors().receiverColor,
                )),
          ),
        ),
      ],
    );
  }
}
