import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/videos.dart';

Stream<List<Video>> getVideosStream(var id) async* {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Getting all the subscribed coaches ids
  QuerySnapshot<Map<String, dynamic>> doc = await firestore
      .collection('DemoVideos')
      .where('CoachId', isEqualTo: id)
      .get();

  List demoVideoIds = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return data['videoId'];
  }).toList();

  // Splitting "demo_video_ids" into smaller batches
  List<List<dynamic>> batches = [];
  const int batchSize = 10;
  for (int i = 0; i < demoVideoIds.length; i += batchSize) {
    final end = i + batchSize < demoVideoIds.length
        ? i + batchSize
        : demoVideoIds.length;
    batches.add(demoVideoIds.sublist(i, end));
  }

  // Getting videos using multiple queries
  List<Video> videos = [];
  for (final batch in batches) {
    QuerySnapshot<Map<String, dynamic>> doc = await firestore
        .collection('Videos')
        .where('videoId', whereIn: batch)
        .get();

    videos.addAll(doc.docs.map((snapshot) {
      Map<String, dynamic> data = snapshot.data();
      return Video(
        videoId: data['videoId'],
        videoTitle: data['videoTitle'],
        videoDescription: data['videoDescription'],
        videoUrl: data['videoUrl'],
        videoThumbnail: data['videoThumbnail'],
      );
    }).toList());
  }
  yield videos;
}

Stream<List<Video>> getScheduleVideos(List VideosIds) async* {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Split the videoIds into smaller batches if the length is greater than 10
  List<List<dynamic>> batches = [];
  const int batchSize = 10;
  for (int i = 0; i < VideosIds.length; i += batchSize) {
    final end =
        i + batchSize < VideosIds.length ? i + batchSize : VideosIds.length;
    batches.add(VideosIds.sublist(i, end));
  }

  // Getting videos using multiple queries
  List<Video> videos = [];
  for (final batch in batches) {
    QuerySnapshot<Map<String, dynamic>> doc = await firestore
        .collection('Videos')
        .where('videoId', whereIn: batch)
        .get();
    videos.addAll(doc.docs.map((snapshot) {
      Map<String, dynamic> data = snapshot.data();
      return Video(
        videoId: data['videoId'],
        videoTitle: data['videoTitle'],
        videoDescription: data['videoDescription'],
        videoUrl: data['videoUrl'],
        videoThumbnail: data['videoThumbnail'],
      );
    }).toList());
  }
  yield videos;
}
