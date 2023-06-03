import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/get_subscriber_clients.dart';
import '../utils/colors.dart';
import '../widgets/custom_background.dart';

class SubscriberClients extends StatelessWidget {
  const SubscriberClients({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ClipPath(
          clipper: CustomClipperPath(),
          child: Container(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                color: AppColors().primaryColor,
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: const Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subscriber Clients",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Here are your subscribers",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 320.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Consumer(
              builder: (context, ref, _) {
                // Getting coaches List
                final coaches = ref.watch(subscribed_clients);
                return coaches.when(
                  data: (userModelList) => userModelList.isEmpty
                      ? Center(
                          child: Text(
                            'You Have No Clients Yet...',
                            style: TextStyle(
                              color: AppColors().primaryColor,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.all(10),
                              sliver: SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final userModel = userModelList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => PublicProfile(
                                        //               userModel: userModel,
                                        //             )));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/img.png'),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage(
                                                        'assets/img.png'),
                                                  ),
                                                  Text(
                                                    userModel.firstName,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
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
                        ),
                  error: (error, stackTrace) => Center(
                    child: Text(
                      'Error $error',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        )
      ],
    ));
  }
}
