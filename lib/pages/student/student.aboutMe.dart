// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/services/logout.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class StudentAbout extends StatefulWidget {
  const StudentAbout({Key? key}) : super(key: key);

  @override
  State<StudentAbout> createState() => _StudentAboutState();
}

class _StudentAboutState extends State<StudentAbout> {
  late Box userDataBox;
  String studentName = "";
  String studentClass = "";
  String username = "";
  String userMobile = "";
  String userDob = "";
  String _profilePictureFileName = "no file selected";
  String _profilePictureFilePath = "";
  File? _profilePictureFile;

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
            GestureDetector(
              onTap: () {
                print("Profile Dialog Open!");
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        title: const Text(
                          "Choose a profile picture",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),
                        ),
                        content: Text(
                          "File: $_profilePictureFilePath",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        actions: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  print(
                                      "Uploaded Image: $_profilePictureFilePath");
                                  setState(() {
                                    _profilePictureFile =
                                        File(_profilePictureFilePath);
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                child: const Text(
                                  "Upload",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  _selectImageFromGallery(setState);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                child: const Text(
                                  "Select image",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
              child: _profilePictureFile == null
                  ? Image.asset("assets/home/student/profile.png", width: 100.0)
                  : Text(_profilePictureFilePath),
            ),
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
                onTap: () {
                  Logout.logout(context);
                  print("About Me: Logout completed");
                },
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

  Future<String> _selectImageFromGallery(Function setState) async {
    String returnedImageName = "";
    try {
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      print("returnedImage ${returnedImage!.path}");
      if (returnedImage != null) {
        returnedImageName = returnedImage.name;
        setState(() {
          _profilePictureFilePath = returnedImage.path;
          _profilePictureFileName = returnedImage.name;
        });
        print("File Selected: $_profilePictureFilePath");
      }
    } catch (e) {
      print("Error in aboutMe file: $e");
    }
    return returnedImageName;
  }
}
