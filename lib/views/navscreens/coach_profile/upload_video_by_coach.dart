import 'dart:io';

import 'package:coachingapp/models/videos.dart';
import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/viewmodels/auth.dart';
import 'package:coachingapp/widgets/large_button_blue.dart';
import 'package:coachingapp/widgets/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}
// Necessary variables

class _UploadVideoState extends State<UploadVideo> {
  final title = TextEditingController();
  final description = TextEditingController();
  List<File> videosforupload = [];
  Uint8List? thumbnail;

  Future<List<File>> pickFiles(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: AppColors().primaryColor,
              ),
            ));
    List<File> videos = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    if (result != null) {
      for (PlatformFile file in result.files) {
        String? path = file.path;
        if (path != null) {
          thumbnail = await VideoThumbnail.thumbnailData(
            video: path,
            imageFormat: ImageFormat.JPEG,
            quality: 100,
          );

          File videoFile = File(path);
          String videoId = DateTime.now().millisecondsSinceEpoch.toString();
          File thumbnailFile =
              await convertThumbnailToImage(thumbnail!, videoId);
          String thumbnailUrl = await uploadThumbnail(thumbnailFile, videoId);

          videos.add(videoFile);
        }
      }
    }
    Navigator.pop(context);
    return videos;
  }

  Future<List<Video>> uploadVideos(List<File> videos) async {
    List<Video> downloadURLs = [];
    FirebaseStorage storage = FirebaseStorage.instance;

    for (int i = 0; i < videos.length; i++) {
      File videoFile = videos[i];
      String fileName = videoFile.path.split('/').last;
      Reference storageRef = storage.ref().child('videos/$fileName');
      UploadTask uploadTask = storageRef.putFile(videoFile);
      await uploadTask;
      String downloadURL = await storageRef.getDownloadURL();

      String videoId = DateTime.now().millisecondsSinceEpoch.toString();
      File thumbnailFile = await convertThumbnailToImage(thumbnail!, videoId);
      String thumbnailUrl = await uploadThumbnail(thumbnailFile, videoId);

      Video video = Video(
        videoId: videoId,
        videoTitle: title.text,
        videoDescription: description.text,
        videoUrl: downloadURL,
        videoThumbnail: thumbnailUrl,
      );

      Auth().StoreVideos(video);
      downloadURLs.add(video);
    }
    return downloadURLs;
  }

  Future<File> convertThumbnailToImage(
      Uint8List thumbnailData, String videoId) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String imagePath = '$tempPath/$videoId.jpg';
    File imageFile = File(imagePath);
    await imageFile.writeAsBytes(thumbnailData);
    return imageFile;
  }

  Future<String> uploadThumbnail(File thumbnailFile, String videoId) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileName = 'thumbnails/$videoId.jpg';
    Reference storageRef = storage.ref().child(fileName);
    UploadTask uploadTask = storageRef.putFile(thumbnailFile);
    await uploadTask;
    String downloadURL = await storageRef.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Add Workout",
            style: TextStyle(color: AppColors().darKShadowColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.04, horizontal: screenWidth * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Title",
                    style: TextStyle(
                        color: AppColors().darKShadowColor, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'Add a title eg: Warm up',
                    hintStyle: TextStyle(color: AppColors().darKShadowColor),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(
                        color: AppColors().darKShadowColor, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TextField(
                  controller: description,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'What training are you doing',
                    hintStyle: TextStyle(color: AppColors().darKShadowColor),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upload Video",
                    style: TextStyle(
                        color: AppColors().darKShadowColor, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                thumbnail != null
                    ? Container(
                        height: screenHeight * 0.2,
                        width: screenWidth,
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: MemoryImage(thumbnail!),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.play_circle,
                            color: AppColors().primaryColor,
                            size: 50,
                          ),
                        ))
                    : Container(),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    // hintText: filneCount == ""
                    //     ? 'Select a video'
                    //     : 'You have selected $filneCount videos',
                    hintText: 'Select a video',
                    hintStyle: TextStyle(color: AppColors().darKShadowColor),
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        List<File> videos = await pickFiles(context);
                        setState(() {
                          videosforupload = videos;
                        });
                      },
                      child: Icon(
                        Icons.play_circle,
                        color: AppColors().primaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                LargeButton(
                  name: "Upload",
                  onPressed: () async {
                    //CircularProgressIndicator();
                    showDialog(
                        context: context,
                        builder: (context) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors().primaryColor,
                              ),
                            ));

                    List<Video> downloadURLs =
                        await uploadVideos(videosforupload);

                    if (downloadURLs.length == videosforupload.length) {
                      title.clear();
                      description.clear();
                      setState(() {
                        videosforupload = [];
                        thumbnail = null;
                      });
                      Navigator.pop(context);
                      showSnackBar(context, "Upload complete");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
