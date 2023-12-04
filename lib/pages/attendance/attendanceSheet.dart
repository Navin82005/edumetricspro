// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:edumetricspro/components/attendanceComponents/components.dart';
import 'package:edumetricspro/components/staff/menuDrawer.dart';
import 'package:edumetricspro/services/students.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AttendanceSheet extends StatefulWidget {
  final classIndex;
  final String className;
  const AttendanceSheet({
    super.key,
    required this.classIndex,
    required this.className,
  });

  @override
  State<AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  List<dynamic> studentsNames = [
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
    ['Student', 'rollNumber'],
  ];

  int numberOfStudent = 15;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBackendData();
  }

  loadBackendData() async {
    var data = await get_students_data(widget.className);
    var data1 = json.decode(data.body);
    var decoded = json.decode(data1['body']);

    // studentsNames = data1['body'] as List<List>;
    // for (var i in data1['body']) {
    //   print(i);
    // }
    // print(studentsNames.elementAt(0));
    setState(() {
      studentsNames = decoded;
      numberOfStudent = studentsNames.length;
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
        title: Text(
          widget.className,
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_open),
              padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
            );
          })
        ],
      ),
      drawer: StaffMenu(),
      body: (loading)
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade50,
              highlightColor: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
                child: ListView.builder(
                  itemCount: numberOfStudent,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                // studentsNames[index][0],
                                "Name",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                // studentsNames[index][0],
                                "Name",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            const Spacer(),
                            AttendanceCheckBox(
                                isChecked: studentsNames[index][2]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
              child: ListView.builder(
                itemCount: numberOfStudent,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              studentsNames[index][0],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              studentsNames[index][1],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white70,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          // const Spacer(),
                          AttendanceCheckBox(
                              isChecked: studentsNames[index][2]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
