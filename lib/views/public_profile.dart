import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/user.dart';
import 'package:coachingapp/viewmodels/auth.dart';
import 'package:coachingapp/views/navscreens/chat/chat_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../models/videos.dart';
import '../providers/coach_followers.dart';
import '../providers/get_demoVideos.dart';
import '../providers/get_user_type.dart';
import '../utils/colors.dart';
import '../viewmodels/storage_method.dart';
import '../widgets/demo_video_player.dart';
import '../widgets/image_picker.dart';
import '../widgets/snackbar.dart';

class PublicProfile extends StatefulWidget {
  final UserModel userModel;
  const PublicProfile({Key? key, required this.userModel}) : super(key: key);

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  final title = TextEditingController();
  final experience = TextEditingController();
  final projects = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Uint8List? _image;
  bool load = false;
  void selectImage() async {
    try {
      setState(() {
        load = true;
      });
      Uint8List im = await pickImage(ImageSource.gallery);
      setState(() {
        _image = im;
      });
      setState(() {
        load = false;
      });
    } catch (e) {
      showSnackBar(context, "error");
    }
  }

  void upload(image) async {
    try {
      setState(() {
        load = true;
      });
      String photoUrl =
          await StorageMethod().uploadImageToStorage('profilePic', image);
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'photoUrl': photoUrl});
      print(photoUrl);
      setState(() {
        load = false;
      });
      showSnackBar(context, "Profile Updated");
    } catch (e) {
      showSnackBar(context, "error");
    }
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
              user != widget.userModel.uid
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.02,
                          bottom: screenHeight * 0.02),
                      child: CircleAvatar(
                        radius: screenWidth * 0.15,
                        backgroundColor: AppColors().primaryColor,
                        child: CircleAvatar(
                          radius: screenWidth * 0.145,
                          backgroundImage:
                              NetworkImage(widget.userModel.photoUrl),
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
                                        ? const Icon(Icons.check)
                                        : GestureDetector(
                                            onTap: () {
                                              Auth().Subscirbe(
                                                  widget.userModel.uid);
                                              ref.refresh(subscriptionProvider);
                                            },
                                            child: const Icon(Icons.add),
                                          ),
                                    orElse: () =>
                                        const CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: 8.0, top: screenHeight * 0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              child: CircleAvatar(
                                radius: screenWidth * 0.15,
                                backgroundColor: AppColors().primaryColor,
                                child: _image != null
                                    ? CircleAvatar(
                                        radius: screenWidth * 0.14,
                                        backgroundImage: MemoryImage(_image!),
                                      )
                                    : Consumer(
                                        builder: (context, ref, _) {
                                          final userResult =
                                              ref.read(userProvider);
                                          return userResult.when(
                                            data: (userModel) {
                                              return CircleAvatar(
                                                radius: screenWidth * 0.14,
                                                backgroundImage: NetworkImage(
                                                    userModel.photoUrl),
                                              );
                                            },
                                            loading: () => const Text("..."),
                                            error: (error, stackTrace) =>
                                                Text('Error: $error'),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ),
                          _image != null
                              ? load
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: AppColors().primaryColor,
                                    ))
                                  : TextButton(
                                      onPressed: () => upload(_image),
                                      child: Text(
                                        "Tap to Upload",
                                        style: TextStyle(
                                            color: AppColors().primaryColor,
                                            fontSize: 16),
                                      ))
                              : TextButton(
                                  onPressed: () => selectImage(),
                                  child: Text(
                                    "Tap to Choose",
                                    style: TextStyle(
                                        color: AppColors().primaryColor,
                                        fontSize: 16),
                                  ),
                                )
                        ],
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.userModel.firstName,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  if (user == widget.userModel.uid)
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Form(
                              key: _formKey,
                              child: AlertDialog(
                                title: const Text('Add Subscription Details'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: title,
                                      keyboardType: TextInputType.name,
                                      decoration: const InputDecoration(
                                          labelText: 'Title'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter experience';
                                        }
                                        final letters = value.replaceAll(
                                            RegExp(r'[^a-zA-Z]'),
                                            ''); // Remove non-letter characters
                                        if (letters.length > 30) {
                                          return 'Please enter up to 30 letters';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: experience,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Experiene in years'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter experience';
                                        }
                                        final number = int.tryParse(value);
                                        if (number == null) {
                                          return 'Please enter a valid number';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: projects,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Projects Count'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a Projects Count';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors().primaryColor),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        updateUserData(title.text,
                                            experience.text, projects.text);
                                        Navigator.pop(context);
                                      }
                                      showSnackBar(
                                          context, "Field can't be empty");
                                      // Close the dialog
                                    },
                                    child: const Text('Update'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors().primaryColor,
                      ),
                    )
                  else
                    Container(),
                ],
              ),
              user == widget.userModel.uid
                  ? Consumer(builder: (context, ref, _) {
                      final userResult = ref.read(userProvider);
                      return userResult.when(
                        data: (userModel) {
                          return Text(
                            userModel.title!,
                            style: TextStyle(
                                fontSize: 16, color: AppColors().primaryColor),
                          );
                        },
                        loading: () => const Text("..."),
                        error: (error, stackTrace) => Text('Error: $error'),
                      );
                    })
                  : Text(
                      widget.userModel.title!,
                      style: TextStyle(
                          fontSize: 16, color: AppColors().primaryColor),
                    ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatList(),
                    ),
                  );
                },
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer(builder: (context, ref, _) {
                      final userResult = ref.read(userProvider);
                      final followers = ref
                          .watch(
                              getCoachFollowersProvider(widget.userModel.uid))
                          .value;
                      return userResult.when(
                        data: (userModel) {
                          return Column(
                            children: [
                              Text("Followers"),
                              Text(
                                followers.toString(),
                                style: TextStyle(fontSize: 28),
                              ),
                            ],
                          );
                        },
                        loading: () => const Text("..."),
                        error: (error, stackTrace) => Text('Error: $error'),
                      );
                    }),
                    user != widget.userModel.uid
                        ? Consumer(builder: (context, ref, _) {
                            final userResult = ref.read(userProvider);
                            ref.refresh(userProvider);
                            return userResult.when(
                              data: (userModel) {
                                return Column(
                                  children: [
                                    Text("Experince"),
                                    Text(
                                      userModel.experience.toString(),
                                      style: TextStyle(fontSize: 28),
                                    ),
                                  ],
                                );
                              },
                              loading: () => const Text("..."),
                              error: (error, stackTrace) =>
                                  Text('Error: $error'),
                            );
                          })
                        : Column(
                            children: [
                              Text("Experince"),
                              Text(
                                widget.userModel.experience.toString(),
                                style: TextStyle(fontSize: 28),
                              ),
                            ],
                          ),
                    user == widget.userModel.uid
                        ? Consumer(builder: (context, ref, _) {
                            final userResult = ref.read(userProvider);
                            ref.refresh(userProvider);
                            return userResult.when(
                              data: (userModel) {
                                return Column(
                                  children: [
                                    Text("Projects"),
                                    Text(
                                      userModel.projects.toString(),
                                      style: TextStyle(fontSize: 28),
                                    ),
                                  ],
                                );
                              },
                              loading: () => const Text("..."),
                              error: (error, stackTrace) =>
                                  Text('Error: $error'),
                            );
                          })
                        : Column(
                            children: [
                              Text("Projects"),
                              Text(
                                widget.userModel.projects.toString(),
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

  Future<void> updateUserData(
      String title, String experience, String projects) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'title': title,
        'experience': experience,
        'projects': projects,
      });
      showSnackBar(context, "User Data Updated Successfully");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
