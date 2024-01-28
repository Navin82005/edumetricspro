import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/student/student.aboutMe.dart';
import 'package:edumetricspro/pages/student/student.attendance.dart';
import 'package:edumetricspro/pages/student/student.drawer.dart';
import 'package:edumetricspro/pages/student/student.markSheet.dart';
import 'package:edumetricspro/pages/student/student.timetable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  late Box userDataBox;
  String studentName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    userDataBox = await Hive.openBox('userData');
    setState(() {
      studentName = userDataBox.get('name');
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
      drawer: const StudentDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(SlideLiftRoute(child: const StudentAttendance()));
              },
              child: Container(
                height: 100,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: (BorderRadius.all(Radius.circular(10.0))),
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.orange,
                      Colors.red,
                      Colors.red
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.2, 0.5, 0.8],
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image(
                        image: AssetImage('assets/home/staff/attendance.png'),
                        height: 40.0,
                      ),
                    ),
                    Text(
                      "Attendance",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(SlideLiftRoute(child: const StudentTimetable()));
              },
              child: Container(
                height: 100,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: (BorderRadius.all(Radius.circular(10.0))),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.green,
                      Colors.teal,
                      Colors.teal,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.2, 0.5, 0.8],
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image(
                        image: AssetImage('assets/home/staff/time-table.png'),
                        height: 40.0,
                      ),
                    ),
                    Text(
                      "Time Table",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(SlideLiftRoute(child: const StudentMarkSheet()));
              },
              child: Container(
                height: 100,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: (BorderRadius.all(Radius.circular(10.0))),
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink,
                      Colors.pink,
                      Colors.deepPurple,
                      Colors.deepPurple,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.2, 0.5, 0.8],
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image(
                        image: AssetImage('assets/home/staff/results.png'),
                        height: 40.0,
                      ),
                    ),
                    Text(
                      "My Marks",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  SlideLiftRoute(
                    child: const StudentAbout(),
                  ),
                );
              },
              child: Container(
                height: 100,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: (BorderRadius.all(Radius.circular(10.0))),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.blue,
                      Colors.lightBlue,
                      Colors.lightBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.2, 0.5, 0.8],
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image(
                        image: AssetImage('assets/home/staff/about-me.png'),
                        height: 40.0,
                      ),
                    ),
                    Text(
                      "About Me",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
