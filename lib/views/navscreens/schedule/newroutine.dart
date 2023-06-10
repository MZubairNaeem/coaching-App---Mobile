import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/get_all_client_schedule.dart';
import '../../../providers/get_subscriber_clients.dart';
import '../../../utils/colors.dart';
import '../../../widgets/Clients_list_alertDialog.dart';
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
                return schedule.when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showClients(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 20.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color:
                                      AppColors().whiteColor.withOpacity(0.8),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Icon(Icons.access_time,
                                            color: Colors.black45),
                                        SizedBox(
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
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (e, s) => Text(e.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final checkedItemIdsProvider =
      StateNotifierProvider<CheckedItemIdsNotifier, List<String>>(
          (ref) => CheckedItemIdsNotifier());

  void showClients(BuildContext context) {
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
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select Clients',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final clients = ref.watch(subscribed_clients);
                    final checkedItemIds =
                        ref.watch(checkedItemIdsProvider.notifier);

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
                                      margin: const EdgeInsets.all(5.0),
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
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            value: checkedItemIds.state
                                                .contains(data[index].uid),
                                            onChanged: (value) {
                                              checkedItemIds
                                                  .toggleCheckedItemId(
                                                      data[index].uid);
                                            },
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text(
                                            data[index].firstName,
                                            style: TextStyle(
                                              color: AppColors().blackColor,
                                              fontSize: 22,
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
                  child: Consumer(
                    builder: (context, ref, _) => ElevatedButton(
                      onPressed: () {
                        final selectedIds = ref.read(checkedItemIdsProvider);
                        print(selectedIds);
                        // Perform actions with selected clients
                        //Navigator.pop(context); // Close the dialog
                      },
                      child: Text('Confirm'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
