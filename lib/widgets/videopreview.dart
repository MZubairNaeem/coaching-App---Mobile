import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../utils/colors.dart';

class VideoPreview extends StatefulWidget {
  final VideoURL;
  const VideoPreview({super.key, required this.VideoURL});

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  @override
  Widget build(BuildContext context) {
    Future<Uint8List> getThumbnail(String videoPath) async {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.PNG,
        quality: 25,
      );
      return uint8list!;
    }

    final thumbnailProvider = FutureProvider<Uint8List>((ref) async {
      final thumbnail = await getThumbnail(widget.VideoURL);
      return thumbnail;
    });

    return Consumer(
      builder: (context, ref, _) {
        final thumbnail = ref.watch(thumbnailProvider);
        return thumbnail.when(
            data: (thumbnail) => Container(
                // height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(thumbnail),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle,
                    color: AppColors().primaryColor,
                    size: 25,
                  ),
                )),
            loading: () => CircularProgressIndicator(),
            error: (error, stackTrace) => const Center(
                  child: Text("Error"),
                ));
      },
    );
  }
}
