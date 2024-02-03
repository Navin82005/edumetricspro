// ignore_for_file: non_constant_identifier_names

import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StaffAbout extends StatefulWidget {
  const StaffAbout({super.key});

  @override
  State<StaffAbout> createState() => _StaffAboutState();
}

class _StaffAboutState extends State<StaffAbout> {
  late Box userDataBox;
  String studentName = "";
  String studentClass = "";
  String username = "";
  String userMobile = "";
  String userDob = "";

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    userDataBox = await Hive.openBox('userData');
    setState(() {
      studentName = userDataBox.get('name');
      studentClass = userDataBox.get('lectureHall');
      username = userDataBox.get('username');
      userMobile = userDataBox.get('userMobile');
      userDob = userDataBox.get('userDob');
      print("studentClass.aboutMe studentClass: $studentClass");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      // backgroundColor: Color(0xFF01010F),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "EduMatricsPro",
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IconButton(
                onPressed: () => print("About me: Settings Icon"),
                icon: const Icon(Icons.settings),
              )),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Personal Information",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => print("Inside About me: Edit Profile"),
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    "Edit",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            PersonalInfo(),
            const SizedBox(
              height: 20.0,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Utilities",
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
            Utilities(),
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
            Image.asset("assets/home/student/profile.png", width: 100.0),
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

  Widget Utilities() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color.fromRGBO(54, 50, 217, .5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => print("About Me: Change Password"),
                child: const Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.change_circle_rounded,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              RowDivider(),
              GestureDetector(
                onTap: () => print("About Me: Change Profile Pic"),
                child: const Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_2,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                            child: Text(
                              "Change Profile Picture",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              RowDivider(),
              GestureDetector(
                onTap: () => print("About Me: Change Password"),
                child: const Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_outlined,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                            child: Text(
                              "Log-Out",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right,
                          ),
                        ],
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
