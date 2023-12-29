import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/components/staff/menuDrawer.dart';
import 'package:edumetricspro/pages/attendance/attendanceSheet.dart';
import 'package:edumetricspro/services/classes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class AttendanceTaker extends StatefulWidget {
  const AttendanceTaker({super.key});

  @override
  State<AttendanceTaker> createState() => _AttendanceTakerState();
}

class _AttendanceTakerState extends State<AttendanceTaker> {
  bool loading = true;
  int classes = 4;
  List<String> classNames = [
    "2 CSE - B",
    "1 CSE - C",
    "3 CSE - B",
    "3 CSE - A"
  ];
  List<String> classTimes = [
    "8:30AM-9:30AM",
    "10:00AM-10:45AM",
    "11:05AM-12:35PM",
    "1:20PM-2:05PM",
  ];
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    Box userData = await Hive.openBox('userData');
    DateTime today = DateTime.now();
    if (userData.get('timings') == null &&
        userData.get('day') != today.weekday) {
      print(today.weekday);
      var data = await get_staff_timetable(userData.get('username'));
      print(data);
      List<String> tempClass = [];
      List<String> tempTime = [];
      for (var i in data['timetable']) {
        tempClass.add(i['class']);
        tempTime.add(i['time']);
      }
      print(tempClass);
      setState(() {
        classes = tempClass.length;
        classNames = tempClass;
        classTimes = tempTime;
      });
    }
    setState(() {
      loading = false;
    });
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
      drawer: const StaffMenu(),
      body: loading
          ? LiquidPullToRefresh(
              onRefresh: () => _refresh(),
              animSpeedFactor: 5,
              showChildOpacityTransition: false,
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade50,
                  highlightColor: Colors.white70,
                  child: ListView.builder(
                    itemCount: classes,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40.0,
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                classNames[index],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                classTimes[index],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            )
          : LectureHalls(),
    );
  }

  // ignore: non_constant_identifier_names
  LiquidPullToRefresh LectureHalls() {
    return LiquidPullToRefresh(
      onRefresh: () => _refresh(),
      animSpeedFactor: 5,
      showChildOpacityTransition: false,
      child: ListView.builder(
        itemCount: classes,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                SlideLiftRoute(
                  child: AttendanceSheet(
                    classIndex: index,
                    className: classNames[index],
                    classTime: classTimes[index],
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      classNames[index],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      classTimes[index],
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
              ),
            ),
          );
        },
      ),
    );
  }
}
