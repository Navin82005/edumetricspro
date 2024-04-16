// ignore_for_file: unused_local_variable

import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/student/student.years.dart';
import 'package:edumetricspro/services/student.marks.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentMarkSheet extends StatefulWidget {
  const StudentMarkSheet({super.key});

  @override
  State<StudentMarkSheet> createState() => _StudentMarkSheetState();
}

class _StudentMarkSheetState extends State<StudentMarkSheet> {
  late SharedPreferences userDataBox;
  String studentName = "";
  Map<String, dynamic> years = {
    "Sem 1": {
      "IIT": ["1", "2", "3"],
      "currentSem": false,
    },
    "Sem 2": {
      "IIT": ["1", "2", "3"],
      "currentSem": false,
    },
    "Sem 3": {
      "IIT": ["1", "2", "3"],
      "currentSem": true,
    },
    "Sem 4": {
      "IIT": ["1", "2", "3"],
      "currentSem": false,
    },
    "Sem 5": {
      "IIT": ["1", "2", "3"],
      "currentSem": false,
    },
  };
  List<String> sems = [];

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    userDataBox = await SharedPreferences.getInstance();
    await requestMarks();
    for (var element in years.keys) {
      sems.add(element);
    }
    setState(() {
      studentName = userDataBox.getString('name') ?? "";
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: IITMarks(),
            ),
          ],
        ),
      ),
    );
  }

  Widget IITMarks() {
    return ListView.separated(
      itemCount: sems.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            SlideLiftRoute(
              child: SemMarks(
                sem: sems[index],
              ),
            ),
          );
        },
        child: Container(
          height: 40.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromRGBO(0, 0, 0, 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  sems[index],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
              if (years[sems[index]]['currentSem'])
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Current Sem",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              const Spacer(),
              const Icon(Icons.navigate_next),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}
