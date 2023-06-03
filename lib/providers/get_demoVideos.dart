import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/videos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final demoVideos = FutureProvider<List<Video>>((ref) async {
  String res = "Some error has occurred";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    QuerySnapshot<Map<String, dynamic>> doc = await _firestore
        .collection('DemoVideos')
        .where('CoachId', isEqualTo: _auth.currentUser!.uid)
        .get();

    List demo_video_ids = doc.docs.map((snapshot) {
      Map<String, dynamic> data = snapshot.data();
      return data['videoId'];
    }).toList();

    List<Video> videos = [];

    // Perform batched queries
    for (int i = 0; i < demo_video_ids.length; i += 10) {
      List<dynamic> batchIds = demo_video_ids.sublist(
          i, i + 10 > demo_video_ids.length ? demo_video_ids.length : i + 10);

      QuerySnapshot<Map<String, dynamic>> batchDocs = await _firestore
          .collection('Videos')
          .where('videoId', whereIn: batchIds)
          .get();

      List<Video> batchVideos = batchDocs.docs.map((snapshot) {
        Map<String, dynamic> data = snapshot.data();
        return Video(
          videoId: data['videoId'],
          videoTitle: data['videoTitle'],
          videoDescription: data['videoDescription'],
          videoUrl: data['videoUrl'],
          videoThumbnail: data['videoThumbnail'],
        );
      }).toList();

      videos.addAll(batchVideos);
    }

    print("Videos: $videos");
    return videos;
  } catch (e) {
    print("Error in get_demoVideos.dart");
    print(e);
    return [];
  }
});
