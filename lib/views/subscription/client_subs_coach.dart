import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_background.dart';
import '../../providers/show_coach_sub_to_client.dart';

class ClientSubCoach extends StatefulWidget {
  final String uid;
  const ClientSubCoach({
    super.key,
    required this.uid,
  });

  @override
  State<ClientSubCoach> createState() => _ClientSubCoachState();
}

class _ClientSubCoachState extends State<ClientSubCoach> {
  bool isLoacding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomClipperPath(),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors().primaryColor,
                  ),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Coach Subscrition Plans",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Choose according to your need",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, _) {
                        final coach =
                            ref.watch(showCoachScheduleProvider(widget.uid));
                        ref.refresh(showCoachScheduleProvider(widget.uid));
                        return coach.when(
                          data: (data) {
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    leading: Text(
                                      data[index].subscriptionType.toString(),
                                    ),
                                    title: Text(
                                      data[index].timeline.toString(),
                                    ),
                                    subtitle: Text(
                                      '${data[index].price} \$',
                                    ),
                                    trailing: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors()
                                            .primaryColor, // Set the button's background color to redAccent
                                      ),
                                      onPressed: () {},
                                      child: Text("Subscribe"),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (e, s) {
                            return Center(
                              child: Text(e.toString()),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
