import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/assign_schedule.dart';
import 'package:coachingapp/viewmodels/schedule_view_model.dart';
import 'package:coachingapp/views/navscreens/schedule/workout_plan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../models/videos.dart';
import '../../../providers/get_all_client_schedule.dart';
import '../../../providers/get_demoVideos.dart';
import '../../../providers/get_subscriber_clients.dart';
import '../../../utils/colors.dart';
import '../../../widgets/calender_widget.dart';
import '../../../widgets/custom_background.dart';

class NewRoutine extends StatefulWidget {
  const NewRoutine({super.key});

  @override
  State<NewRoutine> createState() => _NewRoutineState();
}

class _NewRoutineState extends State<NewRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const WorkOutPlan()));
        },
        backgroundColor: AppColors().primaryColor,
        child: const Icon(Icons.add),
      ),
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
                height: MediaQuery.of(context).size.height * 0.48,
                child: const Calender()),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                padding: const EdgeInsets.only(top: 230.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: AppColors().whiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors().blackColor.withOpacity(0.2),
                            blurRadius: 10.0,
                            spreadRadius: 5.0)
                      ]),
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Icon(
                            Icons.search,
                            color: AppColors().darKShadowColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  AppColors().lightShadowColor), //<-- SEE HERE
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              width: 1, color: AppColors().lightShadowColor),
                        ),
                        hintText: 'Type Searching',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 380, left: 80.0),
            child: Text("Today's Routine",
                style: TextStyle(
                    color: AppColors().blackColor,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w300)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 415.0),
            child: Consumer(
              builder: (context, ref, _) {
                final schedule = ref.watch(scheduleProvider);
                ref.refresh(scheduleProvider);
                return schedule.maybeWhen(
                  data: (data) => data.isEmpty
                      ? Center(
                          child: Text(
                            'No Schedule',
                            style: TextStyle(
                                color: AppColors().blackColor,
                                fontSize: 28.0,
                                fontWeight: FontWeight.w300),
                          ),
                        )
                      : RefreshIndicator(
                          triggerMode: RefreshIndicatorTriggerMode.onEdge,
                          onRefresh: () {
                            return Future.delayed(
                                const Duration(milliseconds: 500), () {
                              ref.refresh(scheduleProvider);
                            });
                          },
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showClients(context, data[index].id);
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, top: 20.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: AppColors()
                                            .whiteColor
                                            .withOpacity(0.8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors()
                                                  .blackColor
                                                  .withOpacity(0.1),
                                              blurRadius: 10.0,
                                              spreadRadius: 5.0)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40,
                                          top: 20.0,
                                          bottom: 20.0,
                                          right: 20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].title,
                                            style: TextStyle(
                                                color: AppColors().primaryColor,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  BoxShadow(
                                                      color: AppColors()
                                                          .blackColor
                                                          .withOpacity(0.1),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 5.0)
                                                ]),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.access_time,
                                                  color: Colors.black45),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(data[index].description),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, s) => Text(e.toString()),
                  orElse: () => const Center(
                    child: Text("No Schedule"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final demoVideosProvider = StreamProvider<List<Video>>(
    (ref) => getVideosStream(FirebaseAuth.instance.currentUser!.uid),
  );
  final checkedItemIdsProvider = StateProvider<List<String>>((ref) => []);
  final checkedVideosProvider = StateProvider<List<String>>((ref) => []);

  void showClients(BuildContext context, String scheduleId) {
    int count = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors().whiteColor.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Clients',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: AppColors().primaryColor,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final clients = ref.watch(subscribedClients);
                    final checkedItemIds = ref.watch(checkedItemIdsProvider);
                    count = checkedItemIds.length;
                    return clients.when(
                      data: (data) {
                        return data.isEmpty
                            ? const Center(
                                child: Text('No Clients'),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 20.0, top: 20.0),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: AppColors()
                                            .whiteColor
                                            .withOpacity(0.8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors()
                                                .blackColor
                                                .withOpacity(0.1),
                                            blurRadius: 10.0,
                                            spreadRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          RoundCheckBox(
                                              checkedColor:
                                                  AppColors().primaryColor,
                                              checkedWidget: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                              isChecked: checkedItemIds
                                                  .contains(data[index].uid),
                                              onTap: (onTap) {
                                                if (onTap == true) {
                                                  checkedItemIds
                                                      .add(data[index].uid);
                                                  count++;
                                                  print(checkedItemIds);
                                                } else {
                                                  checkedItemIds
                                                      .remove(data[index].uid);
                                                  count--;
                                                  print(checkedItemIds);
                                                }
                                              }),
                                          Text(
                                            data[index].firstName.toUpperCase(),
                                            style: TextStyle(
                                              color: AppColors().blackColor,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (e, s) => Text(e.toString()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigator.pop(context);
                      if (count == 0) {
                        //Flutter toaster
                        Fluttertoast.showToast(
                            msg: "Please select atleast one client",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors().primaryColor,
                            textColor: Colors.white,
                            webPosition: 'left',
                            fontSize: 16.0);
                        return;
                      } else {
                        showVideosList(context, scheduleId);
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showVideosList(BuildContext context, String scheduleId) {
    int count = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors().whiteColor.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Video To Send',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: AppColors().primaryColor,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final clients = ref.watch(demoVideosProvider);
                    final checkedVideoURL = ref.watch(checkedVideosProvider);
                    count = checkedVideoURL.length;
                    return clients.when(
                      data: (data) {
                        return data.isEmpty
                            ? const Center(
                                child: Text('No Videos Found'),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 20.0, top: 20.0),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: AppColors()
                                            .whiteColor
                                            .withOpacity(0.8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors()
                                                .blackColor
                                                .withOpacity(0.1),
                                            blurRadius: 10.0,
                                            spreadRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          RoundCheckBox(
                                              checkedColor:
                                                  AppColors().primaryColor,
                                              checkedWidget: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                              isChecked:
                                                  checkedVideoURL.contains(
                                                      data[index].videoId),
                                              onTap: (onTap) {
                                                if (onTap == true) {
                                                  checkedVideoURL.add(
                                                      data[index]
                                                          .videoId
                                                          .toString());
                                                  count++;
                                                } else {
                                                  checkedVideoURL.remove(
                                                      data[index]
                                                          .videoId
                                                          .toString());
                                                  count--;
                                                }
                                              }),
                                          Text(
                                            data[index].videoTitle.toString(),
                                            style: TextStyle(
                                              color: AppColors().blackColor,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (e, s) => Text(e.toString()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (count == 0) {
                        Fluttertoast.showToast(
                            msg: "Please select atleast one video",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors().primaryColor,
                            textColor: Colors.white,
                            webPosition: 'left',
                            fontSize: 16.0);
                        return;
                      }
                      showConfirmDialogue(context, scheduleId);
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showConfirmDialogue(BuildContext context, String scheduleId) {
    Timestamp timestamp = Timestamp.now();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors().whiteColor.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: AppColors().primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Are you sure you want to send this video to the selected clients?',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: AppColors().blackColor,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final checkedItemIds = ref.watch(checkedItemIdsProvider);
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Selected Clients: ${checkedItemIds.length}',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: AppColors().blackColor,
                        ),
                      ),
                    );
                  },
                ),
                //Chose Date Time
                CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2024),
                  onDateChanged: (date) {
                    timestamp = Timestamp.fromDate(date);
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final checkedVideoURL = ref.watch(checkedVideosProvider);
                    final checkedItemIds = ref.watch(checkedItemIdsProvider);
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          //Show Loading
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor:
                                    AppColors().whiteColor.withOpacity(0.9),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CircularProgressIndicator(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Assigning Schedule ...',
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            color: AppColors().blackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          // ignore: unused_local_variable
                          AssignSchedule assignSchdule = AssignSchedule(
                            scheduleId: scheduleId,
                            videos: checkedVideoURL,
                            clients: checkedItemIds,
                            coachId: FirebaseAuth.instance.currentUser!.uid,
                            assignDate: timestamp,
                            created_at: Timestamp.now(),
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                          );
                          var res = await SchduleViewModel()
                              .AssignedSchedules(assignSchdule);
                          print(res);
                          if (res == 'Success') {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(msg: res.toString());
                          }
                        },
                        child: const Text('Confirm'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
