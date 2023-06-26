import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/coach_app_sub.dart';
import 'package:coachingapp/providers/get_coach_own_schedule.dart';
import 'package:coachingapp/viewmodels/add_plan_by_coach.dart';
import 'package:coachingapp/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/get_user_type.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_background.dart';

class PlanDescription extends StatefulWidget {
  const PlanDescription({super.key});

  @override
  State<PlanDescription> createState() => _PlanDescriptionState();
}

class _PlanDescriptionState extends State<PlanDescription> {
  final _priceController = TextEditingController();
  final _timelineController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? subscriptionType;
  String? dropdownValue;
  bool isLoacding = false;
  int indexCount = 0;
  List<String> item = [
    'Platinum',
    'Gold',
    'Silver',
  ];
  Future<void> addPlan() async {
    try {
      setState(() {
        isLoacding = true;
      });
      if(indexCount >= 3){
        showSnackBar(context, "You can't add more than 3 plans");
        setState(() {
          isLoacding = false;
        });
        return;
      }
      await addCoachPlan(
        dropdownValue.toString(),
        _timelineController.text,
        int.parse(_priceController.text),
        _descriptionController.text,
      );
      setState(() {
        isLoacding = true;
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      setState(() {
        isLoacding = false;
      });
    }
  }

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
                        "Subscrition Plans",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Here are your plans",
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
                        final coach = ref.watch(coachOwnScheduleProvider);
                        final user = FirebaseAuth.instance.currentUser;
                        final cc =
                            ref.watch(getCoachTotalScheduleProvider(user?.uid)).value;
                            indexCount = cc!;
                        ref.refresh(coachOwnScheduleProvider);
                        return coach.when(
                          data: (data) {
                            indexCount = data.length;
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
                                      data[index].price.toString() + ' ' + '\$',
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        print(data[index]
                                            .subscriptionId
                                            .toString());
                                        await deleteCoachPlan(data[index]
                                            .subscriptionId
                                            .toString());
                                      },
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Subscription Details'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Price'),
                    ),
                    TextField(
                      controller: _timelineController,
                      decoration: const InputDecoration(labelText: 'Timeline'),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DropdownButtonFormField(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: AppColors().darKShadowColor,
                      ),
                      hint: const Text('Select Type'),
                      items: item
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          dropdownValue = val as String;
                          print(val.toString());
                        });
                      },
                      value: dropdownValue,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors().primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      // Perform the desired action with the entered subscription details
                      addPlan();

                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        backgroundColor: AppColors().primaryColor,
        label: const Text("Add Plan"),
      ),
    );
  }

  deleteCoachPlan(String? id) async {
    try {
      await FirebaseFirestore.instance
          .collection('CoachSubPlan')
          .doc(id)
          .delete();
      showSnackBar(context, "Document deleted successfully");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
