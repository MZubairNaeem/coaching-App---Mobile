import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/videos.dart';

Stream<List<Video>> getVideosStream(var id) async* {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getting all the subscribed coaches ids
  QuerySnapshot<Map<String, dynamic>> doc = await _firestore
      .collection('DemoVideos')
      .where('CoachId', isEqualTo: id)
      .get();

  List demo_video_ids = doc.docs.map((snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return data['videoId'];
  }).toList();

  // Splitting "demo_video_ids" into smaller batches
  List<List<dynamic>> batches = [];
  final int batchSize = 10;
  for (int i = 0; i < demo_video_ids.length; i += batchSize) {
    final end = i + batchSize < demo_video_ids.length
        ? i + batchSize
        : demo_video_ids.length;
    batches.add(demo_video_ids.sublist(i, end));
  }

  // Getting videos using multiple queries
  List<Video> videos = [];
  for (final batch in batches) {
    QuerySnapshot<Map<String, dynamic>> doc = await _firestore
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
