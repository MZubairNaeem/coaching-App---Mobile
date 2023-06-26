import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/colors.dart';
import '../../../widgets/large_button_trasparent_text_left_align.dart';
import '../../providers/get_user_type.dart';
import '../../viewmodels/storage_method.dart';
import '../../widgets/image_picker.dart';
import '../auth/forget_pass.dart';

class ClientAccount extends StatefulWidget {
  const ClientAccount({Key? key}) : super(key: key);

  @override
  State<ClientAccount> createState() => _ClientAccountState();
}

class _ClientAccountState extends State<ClientAccount> {
  Uint8List? _image;
  bool load = false;
  void SelectImage() async {
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

// void uploadData() async {
//   var user =  FirebaseAuth.instance.currentUser!;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
// final CollectionReference usersCollection = firestore.collection('Users');
//   UploadTask task = FirebaseStorage.instance.ref('profilePic').child(user.uid).putData(_image!);
//   TaskSnapshot snapshot = await task;
//   String url = await snapshot.ref.getDownloadURL();
//    usersCollection.doc(user.uid).update({'photoUrl': url});
// }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.6,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3.6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors().primaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'My Account',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            child: CircleAvatar(
                              radius: screenHeight * 0.053,
                              backgroundColor: Colors.white,
                              child: _image != null
                                  ? CircleAvatar(
                                      radius: screenHeight * 0.05,
                                      backgroundImage: MemoryImage(_image!),
                                    )
                                  : Consumer(
                                      builder: (context, ref, _) {
                                        final userResult =
                                            ref.read(userProvider);
                                        return userResult.when(
                                          data: (userModel) {
                                            return CircleAvatar(
                                              radius: screenHeight * 0.05,
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
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                                : TextButton(
                                    onPressed: () => upload(_image),
                                    child: const Text(
                                      "Tap to Upload",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ))
                            : TextButton(
                                onPressed: () => SelectImage(),
                                child: const Text(
                                  "Tap to Choose",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.38,
                decoration: BoxDecoration(color: AppColors().primaryColor),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.38,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50))),
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight * 0.035),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer(
                            builder: (context, ref, _) {
                              final userResult = ref.read(userProvider);
                              return userResult.when(
                                data: (userModel) {
                                  return Column(
                                    children: [
                                      Text(
                                        userModel.email,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors().darKShadowColor,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                loading: () => CircularProgressIndicator(
                                  color: AppColors().primaryColor,
                                  strokeWidth: 2,
                                ),
                                error: (error, stackTrace) =>
                                    Text('Error: $error'),
                              );
                            },
                          ),
                          Container(
                            height: screenHeight * 0.3,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("First name"),
                                      Consumer(
                                        builder: (context, ref, _) {
                                          final userResult =
                                              ref.read(userProvider);

                                          return userResult.when(
                                            data: (userModel) {
                                              return Column(
                                                children: [
                                                  Text(userModel.firstName),
                                                ],
                                              );
                                            },
                                            loading: () =>
                                                CircularProgressIndicator(
                                              color: AppColors().primaryColor,
                                              strokeWidth: 2,
                                            ),
                                            error: (error, stackTrace) =>
                                                Text('Error: $error'),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors().lightShadowColor,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Phone number"),
                                      Consumer(
                                        builder: (context, ref, _) {
                                          final userResult =
                                              ref.read(userProvider);

                                          return userResult.when(
                                            data: (userModel) {
                                              return Text(
                                                  userModel.phoneNumber);
                                            },
                                            loading: () =>
                                                CircularProgressIndicator(
                                              color: AppColors().primaryColor,
                                              strokeWidth: 2,
                                            ),
                                            error: (error, stackTrace) =>
                                                Text('Error: $error'),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors().lightShadowColor,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Date of birth"),
                                      Consumer(
                                        builder: (context, ref, _) {
                                          final userResult =
                                              ref.read(userProvider);

                                          return userResult.when(
                                            data: (userModel) {
                                              return Text(
                                                  userModel.dateOfBirth);
                                            },
                                            loading: () =>
                                                CircularProgressIndicator(
                                              color: AppColors().primaryColor,
                                              strokeWidth: 2,
                                            ),
                                            error: (error, stackTrace) =>
                                                Text('Error: $error'),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors().lightShadowColor,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Location"),
                                      Consumer(
                                        builder: (context, ref, _) {
                                          final userResult =
                                              ref.read(userProvider);

                                          return userResult.when(
                                            data: (userModel) {
                                              return Text(userModel.location);
                                            },
                                            loading: () =>
                                                CircularProgressIndicator(
                                              color: AppColors().primaryColor,
                                              strokeWidth: 2,
                                            ),
                                            error: (error, stackTrace) =>
                                                Text('Error: $error'),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors().lightShadowColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.005,
                          ),
                          LargeButtonTransparentLeftAlignText(
                            name: "Change Password",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPass()));
                            },
                          ),
                          // LargeButtonTransparentLeftAlignText(
                          //   name: "Settings",
                          //   onPressed: () {},
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
