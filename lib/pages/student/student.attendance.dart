// ignore_for_file: non_constant_identifier_names

import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/student/student.attendanceSheet.dart';
import 'package:edumetricspro/services/student.attendance.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentAttendance extends StatefulWidget {
  const StudentAttendance({super.key});

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  bool loading = false;
  Map subjectNamesAttendance = {
    "OOPS": 90,
    "ADSA": 90,
    "DBMS": 90,
    "DM": 90,
    "Verbal": 90
  };
  List subjectNames = [
    "test",
    "test",
    "test",
    "test",
    "test",
    "test",
    "test",
    "test"
  ];
  int subjectCount = 0;
  List lowAttendance = [true, false, true, false];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? rollnumber = prefs.getString("registerNumber");
    String? sem = prefs.getString("sem");

    if (rollnumber != null && sem != null) {
      print("rollnumber $rollnumber, Sem $sem");
      var rawData = await getAttendancePercentage(rollnumber, sem);
      print("student.attendance.dart rawData: $rawData");

      List temp = [];
      List templowAttendance = [];

      setState(() {
        subjectNamesAttendance = rawData;
      });

      for (var sub in subjectNamesAttendance.keys) {
        temp.add(sub.toString());
        if (subjectNamesAttendance[sub.toString()] < 75) {
          templowAttendance.add(true);
        } else {
          templowAttendance.add(false);
        }
      }

      setState(() {
        subjectNames = temp;
        lowAttendance = templowAttendance;
        subjectCount = subjectNames.length;
      });
    } else {
      print("Roll number or lecture hall not found in shared preferences.");
    }
  }

  Future<void> _refresh() async {
    setState(() {
      loading = true;
    });
    loadData();
    print("Refreshed");
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Attendance Sheet",
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
            child: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu_open),
              );
            }),
          )
        ],
      ),
      body: SubjectsSheet(),
    );
  }

  LiquidPullToRefresh SubjectsSheet() {
    return LiquidPullToRefresh(
      onRefresh: () => _refresh(),
      animSpeedFactor: 5,
      showChildOpacityTransition: false,
      child: ListView.builder(
        itemCount: subjectCount,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideLiftRoute(
                  child: StudentAttendanceSheet(
                    subjectNames: subjectNames[index],
                    // day:
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
              child: (!lowAttendance[index])
                  ? Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (subjectNames[index]).toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${subjectNamesAttendance[subjectNames[index]]}%",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white70,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.navigate_next),
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (subjectNames[index]).toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${subjectNamesAttendance[subjectNames[index]]}%",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
