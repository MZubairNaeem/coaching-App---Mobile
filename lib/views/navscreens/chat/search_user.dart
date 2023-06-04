import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/models/user.dart';
import 'package:coachingapp/widgets/large_button_blue.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors().whiteColor,
          title: Text(
            "Search",
            style: TextStyle(color: AppColors().darKShadowColor),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  fillColor: AppColors().darKShadowColor,
                  focusColor: AppColors().primaryColor,
                  hintStyle: TextStyle(color: AppColors().darKShadowColor),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors().darKShadowColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors().primaryColor, width: 2.0),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              LargeButton(name: "Search", onPressed: () {
                setState(() {
                  
                });
              }),
              SizedBox(
                height: size.height * 0.05,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .where('firstName', isGreaterThanOrEqualTo: searchController.text.trim())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot? dataSnapshot =
                          snapshot.data as QuerySnapshot?;
                      if (dataSnapshot!.docs.length > 0) {
                        Map<String, dynamic>? userMap =
                            dataSnapshot.docs.first.data() as Map<String, dynamic>?;
                        UserModel searchUser = UserModel.fromMap(userMap!);
                        return ListTile(
                          title: Text(searchUser.firstName),
                          subtitle: Text(searchUser.email),
                        );
                      }else{
                        return const Center(child: Text("No Results Found"));}
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("An Error Occured"));
                    } else {
                      return const Center(child: Text("No Results Found"));
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
