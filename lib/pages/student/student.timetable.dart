// // ignore_for_file: prefer_const_constructors

import "package:edumetricspro/components/staff/menuDrawer.dart";
import "package:edumetricspro/services/students.dart";
import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:shimmer/shimmer.dart";
import 'package:shared_preferences/shared_preferences.dart';

class StudentTimetable extends StatefulWidget {
  const StudentTimetable({Key? key}) : super(key: key);

  @override
  State<StudentTimetable> createState() => _StudentTimetableState();
}

class _StudentTimetableState extends State<StudentTimetable> {
  late Map localData;
  late String staffName;
  String dropdown = '';
  int dateTimeNow = 0;
  int tempIndex = 0;
  bool isLoading = true;
  String studentClass = "";
  int timeTableData_length = 63;
  List<dynamic> timeTableData = [
    "08:30 AM - 09:30 AM",
    "Oops",
    "Verbal",
    "DM",
    "ADSA",
    "Dbms",
    "DM",
    "Oops",
    "MPMC",
    "DM",
    "BCE",
    "ADSA",
    "DBMS",
    "OOPS",
    "MPMC",
    "DM",
    "DBMS",
    "OUANTS",
    "DM",
    "BCE",
    "OOPS",
    "DM",
    "DBMS",
    "ADSA",
    "BCE",
    "ADSA",
    "DBMS",
    "OOPS",
    "MPMC",
    "DM",
  ];

  List<Map> tileData = [
    {"period": "Time", "color": Colors.green},
    {"period": "Monday", "color": Colors.green},
    {"period": "Tuesday", "color": Colors.green},
    {"period": "Wednesday", "color": Colors.green},
    {"period": "Thursday", "color": Colors.green},
    {"period": "Friday", "color": Colors.green},
    {"period": "Saturday", "color": Colors.green},
  ];

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
    });
    getLocalData();
  }

  void getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dateTimeNow = DateTime.now().weekday;
      studentClass = prefs.getString('inClass') ?? "";
      tempIndex = dateTimeNow;
      staffName = (prefs.getString('name') ?? "");
    });
    try {
      var tileDataResponse = await get_time_table(studentClass);
      print("tileData: ${tileDataResponse["data"]}");
      setState(() {
        timeTableData = tileDataResponse["data"];
        timeTableData_length = timeTableData.length;
        print(timeTableData_length);
      });

      print("My name: ${prefs.getString('username')}");
    } catch (e) {
      print("Exception in student.timetable: $e");
    }

    setTileData(dateTimeNow, timeTableData);
    setState(() {
      isLoading = false;
    });
  }

  void setTileData(int today, List<dynamic> tiles) {
    tempIndex = 1;
    print("today: $today; temIndex: $tempIndex");
    for (int i = 0; i < tiles.length; i++) {
      var period = tiles[i];
      tileData.add(
          {"period": period, "color": Theme.of(context).colorScheme.surface});

      if (tempIndex == i + 1) {
        tileData[i + 7]['color'] = Colors.green;
        tempIndex += 7;
      } else {
        tileData[i + 7]['color'] = Theme.of(context).colorScheme.surface;
      }
    }
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
          "Time Table",
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
      // StaffAppBar1(),
      // drawer: const StaffMenu(),

      body: (isLoading)
          ? LiquidPullToRefresh(
              animSpeedFactor: 5,
              showChildOpacityTransition: false,
              color: Theme.of(context).colorScheme.primary,
              onRefresh: () => _refresh(),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade50,
                highlightColor: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: GridView.builder(
                    itemCount: 35,
                    padding: const EdgeInsets.all(20.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                      mainAxisExtent: 140.0,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.purple,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                "pass",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : LiquidPullToRefresh(
              animSpeedFactor: 5,
              showChildOpacityTransition: false,
              color: Theme.of(context).colorScheme.primary,
              onRefresh: () => _refresh(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  // textDirection: TextDirection.ltr,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return GridView.builder(
                        itemCount: timeTableData.length + 7,
                        padding: const EdgeInsets.all(20.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 6.0,
                          mainAxisExtent: 140.0,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: tileData[index]['color'],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Center(
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: Text(
                                      tileData[index]['period'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
