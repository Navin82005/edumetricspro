import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentAbout extends StatefulWidget {
  const StudentAbout({super.key});

  @override
  State<StudentAbout> createState() => _StudentAboutState();
}

class _StudentAboutState extends State<StudentAbout> {
  late Box userDataBox;
  String studentName = "";
  String studentClass = "";

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
            child: Text(
              studentName.toString(),
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AboutFirstChild(),
          AboutSecondChild(),
          AboutFirstChild(),
          AboutFirstChild(),
        ],
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

  Widget AboutSecondChild() => Row();
}
