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
  var studentsNames = List<Students>.from(
    [
      {
        "name": "Temp1",
        "class": "Temp2",
        "rollNumber": "Temp3",
        "isPresent": false,
        "isOD": false,
      },
      {
        "name": "Temp1",
        "class": "Temp2",
        "rollNumber": "Temp3",
        "isPresent": false,
        "isOD": false,
      },
      {
        "name": "Temp1",
        "class": "Temp2",
        "rollNumber": "Temp3",
        "isPresent": false,
        "isOD": false,
      },
      {
        "name": "Temp1",
        "class": "Temp2",
        "rollNumber": "Temp3",
        "isPresent": false,
        "isOD": false,
      },
      {
        "name": "Temp1",
        "class": "Temp2",
        "rollNumber": "Temp3",
        "isPresent": false,
        "isOD": false,
      },
      {
        "name": "Temp1",
        "class": "Temp2",
        "rollNumber": "Temp3",
        "isPresent": false,
        "isOD": false,
      },
    ].map(
      (studentData) {
        return Students(
          "Name",
          "X CSE - X",
          'rollNumber',
          false,
          false,
        );
      },
    ),
  ).toList();

  int numberOfStudent = 5;
  bool loading = true;
  var data;
  bool error = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBackendData();
  }

  loadBackendData() async {
    data = await get_students_data(widget.className);
    print(data);
    try {
      if (data['message'] == "Unable to get data") {
        setState(() {
          error = true;
        });
        return;
      }
    } catch (e) {}
    // var data1 = json.decode(data.body);
    // var decoded = json.decode(data1['body']);

    // studentsNames = data1['body'] as List<List>;
    // for (var i in data1['body']) {
    //   print(i);
    // }
    // print(studentsNames.elementAt(0));
    // print(data);
    setState(() {
      // numberOfStudent = studentsNames.length;
      studentsNames = data;
      data = data;
      numberOfStudent = data.length;
      print(numberOfStudent);
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
          ? (!error)
              ? Shimmer.fromColors(
                  baseColor: Colors.white70,
                  highlightColor: Colors.white30,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
                    child: ListView.builder(
                      itemCount: numberOfStudent,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
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
                                    studentsNames[index].rollNumber,
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
                                    studentsNames[index].name,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white70,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                                AttendanceCheckBox(isChecked: true),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    print("object");
                  },
                  child: Center(
                    child: Text(
                      "Unable to Get data from database.\nPlease check your internet connection and try again.",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                )
          : Form(
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
                        child: GestureDetector(
                          onTap: () {
                            putAttendance(
                              index,
                              !studentsNames[index].isPresent,
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  studentsNames[index].name,
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
                                  studentsNames[index].rollNumber,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              // const Spacer(),
                              Checkbox(
                                value: studentsNames[index].isPresent,
                                onChanged: (newBool) {
                                  putAttendance(index, newBool);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  void putAttendance(int index, bool? newBool) {
    return setState(
      () {
        studentsNames[index].isPresent = newBool!;
        // for (var element in studentsNames) {
        //   print("${element.name} ${element.isPresent}");
        // }
      },
    );
  }
}
