// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/services/logout.dart';
import 'package:edumetricspro/services/staff.class.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class StudentProfile extends StatefulWidget {
  final name;
  final rollNumber;
  const StudentProfile(
      {super.key, required this.name, required this.rollNumber});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String studentName = "studentName";
  String studentClass = "studentClass";
  String username = "username";
  String userMobile = "userMobile";
  String userDob = "userDob";

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    var data = await getStaffClassStudent(widget.rollNumber);
    setState(() {
      studentName = data[0]["name"] as String;
      studentClass = data[0]["lectureHall"] as String;
      userMobile = data[0]["userMobile"] as String;
      userDob = data[0]["userDob"] as String;
      username = data[0]["username"] as String;
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
              onPressed: () => print("About me: Settings Icon"),
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AboutFirstChild(),
            const SizedBox(
              height: 30.0,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),
                Spacer(),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            PersonalInfo(),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget AboutFirstChild() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            GestureDetector(
                onTap: () {
                  print("Profile Dialog Open!");
                },
                child: Image.asset("assets/home/student/profile.png",
                    width: 100.0)),
            Text(
              studentName,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              studentClass,
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget RowDivider() => Divider(
        thickness: 1.0,
        color: Theme.of(context).colorScheme.tertiary,
      );

  Widget PersonalInfo() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color.fromRGBO(54, 50, 217, .5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email,
                        ),
                        const Spacer(),
                        Text(
                          username,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              RowDivider(),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone,
                        ),
                        const Spacer(),
                        Text(
                          userMobile,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              RowDivider(),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range_rounded,
                        ),
                        const Spacer(),
                        Text(
                          userDob,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
