import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String? videoId;
  String? videoTitle;
  String? videoUrl;
  String? videoThumbnail;
  String? videoDescription;

  Video(
      {required this.videoId,
      required this.videoTitle,
      required this.videoDescription,
      required this.videoUrl,
      required this.videoThumbnail});

  Map<String, dynamic> toJson() => {
        'videoId': videoId,
        'videoTitle': videoTitle,
        'videoDescription': videoDescription,
        'videoThumbnail': videoThumbnail,
        'videoUrl': videoUrl
      };
  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
        videoId: snapshot['videoId'],
        videoTitle: snapshot['videoTitle'],
        videoDescription: snapshot['videoDescription'],
        videoUrl: snapshot['videoUrl'],
        videoThumbnail: snapshot['videoThumbnail']);
  }
}
