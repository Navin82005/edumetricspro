// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:edumetricspro/components/attendanceComponents/components.dart';
import 'package:edumetricspro/components/staff/menuDrawer.dart';
import 'package:edumetricspro/services/students.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AttendanceSheet extends StatefulWidget {
  final classIndex;
  final String className;
  final String classTime;
  const AttendanceSheet({
    super.key,
    required this.classIndex,
    required this.className,
    required this.classTime,
  });

  @override
  State<AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  List<bool> AttendanceList = [];

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
  String _period = 'PERIOD';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBackendData();
  }

  loadBackendData() async {
    setState(() {
      loading = true;
    });
    data = await get_students_data(
      widget.className,
      widget.classTime,
    );
    // print(data['students']);
    AttendanceList = [];

    try {
      if (data['message'] == "Unable to get data") {
        setState(() {
          error = true;
        });
        print(error);
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
    var rawData = data['students'];

    for (Students i in rawData) {
      AttendanceList.add(i.isPresent);
    }

    setState(() {
      // numberOfStudent = studentsNames.length;
      studentsNames = data['students'];
      data = data;
      _period = data['period'];
      numberOfStudent = studentsNames.length;
      print(numberOfStudent);
      loading = false;
    });
  }

  Future<void> _refresh() async {
    return await loadBackendData();
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
          (loading)
              ? Shimmer.fromColors(
                  baseColor: Colors.white70,
                  highlightColor: Colors.white30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      _period,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    _period,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
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
      drawer: StaffMenu(),
      body: (loading)
          ? (!error)
              ? LiquidPullToRefresh(
                  onRefresh: () => _refresh(),
                  animSpeedFactor: 5,
                  showChildOpacityTransition: false,
                  child: Shimmer.fromColors(
                    baseColor: Colors.white70,
                    highlightColor: Colors.white30,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Name",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Roll Number",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white70,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 0, 10.0, 0),
                                    child: Text(
                                      "Present",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white70,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: numberOfStudent,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30.0, 1.0, 30.0, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          studentsNames[index].isPresent =
                                              !studentsNames[index].isPresent;
                                          AttendanceList[index] =
                                              studentsNames[index].isPresent;
                                        });
                                      },
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
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
                                          Expanded(child: SizedBox()),
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Checkbox(
                                              value: studentsNames[index]
                                                  .isPresent,
                                              onChanged: (newBool) {
                                                setAttendance(index, newBool);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              sendStudentData(
                                  studentsNames, widget.className, _period);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.background,
                              ),
                            ),
                            child: Text(
                              "Save Attendance",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : LiquidPullToRefresh(
                  onRefresh: () => _refresh(),
                  animSpeedFactor: 5,
                  showChildOpacityTransition: false,
                  child: ListView(
                    children: const [
                      Text(
                        "Unable to Get data from database\nPlease check your internet connection and try again.",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                )
          : LiquidPullToRefresh(
              onRefresh: () => _refresh(),
              animSpeedFactor: 5,
              showChildOpacityTransition: false,
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Name",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Roll Number",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
                                child: Text(
                                  "Present",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: numberOfStudent,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30.0, 1.0, 30.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      studentsNames[index].isPresent =
                                          !studentsNames[index].isPresent;
                                      AttendanceList[index] =
                                          studentsNames[index].isPresent;
                                    });
                                  },
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                      Expanded(child: SizedBox()),
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Checkbox(
                                          value: studentsNames[index].isPresent,
                                          onChanged: (newBool) {
                                            setAttendance(index, newBool);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          sendStudentData(
                              studentsNames, widget.className, _period);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.background,
                          ),
                        ),
                        child: Text(
                          "Save Attendance",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void setAttendance(int index, bool? newBool) {
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
