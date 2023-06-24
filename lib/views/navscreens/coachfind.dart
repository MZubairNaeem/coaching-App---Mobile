import 'package:coachingapp/providers/get_user_type.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/colors.dart';
import '../../providers/get_coaches.dart';
import '../public_profile.dart';

class CoachFind extends StatefulWidget {
  const CoachFind({Key? key}) : super(key: key);

  @override
  State<CoachFind> createState() => _CoachFindState();
}

class _CoachFindState extends State<CoachFind> {
  @override
  void initState() {
    Firebase.initializeApp();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Alert",
                style: TextStyle(
                    color: AppColors().primaryColor,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
              content: Text("Are you sure you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    "Yes",
                    style: TextStyle(color: AppColors().primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "No",
                    style: TextStyle(color: AppColors().primaryColor),
                  ),
                ),
              ],
            ),
          );
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Consumer(
                builder: (context, ref, _) {
                  final userResult = ref.watch(userProvider);
                  ref.refresh(userProvider);
                  return userResult.when(
                    data: (userModel) {
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(userModel.photoUrl),
                      );
                    },
                    loading: () => const Text("..."),
                    error: (error, stackTrace) => Text('Error: $error'),
                  );
                },
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style:
                      TextStyle(color: AppColors().darKShadowColor, fontSize: 16),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final userResult = ref.watch(userProvider);
                    ref.refresh(userProvider);
                    return userResult.when(
                      data: (userModel) {
                        return Text(
                          userModel.firstName,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors().darKShadowColor,
                          ),
                        );
                      },
                      loading: () => const Text("..."),
                      error: (error, stackTrace) => Text('Error: $error'),
                    );
                  },
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.1),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors().darKShadowColor,
                  size: 28,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
            child: Consumer(
              builder: (context, ref, _) {
                // Getting coaches List
                final coaches = ref.watch(coachProvider);
                return coaches.when(
                  data: (userModelList) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          floating: true,
                          pinned: false,
                          backgroundColor: Colors.transparent,
                          title: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(10),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final userModel = userModelList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PublicProfile(
                                                  userModel: userModel,
                                                )));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(userModel.photoUrl),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.5),
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      userModel.photoUrl)),
                                              Expanded(
                                                child: Text(
                                                  userModel.firstName,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: userModelList.length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => Text('Error: $error'),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
