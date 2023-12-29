import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/attendance/attendanceTaker.dart';
import 'package:edumetricspro/pages/staff/time_table.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StaffHomeContent extends StatefulWidget {
  const StaffHomeContent({super.key});

  @override
  State<StaffHomeContent> createState() => _StaffHomeContentState();
}

class _StaffHomeContentState extends State<StaffHomeContent> {
  late Box userDataBox;
  bool staffMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    userDataBox = await Hive.openBox('userData');
    setState(() {
      staffMode = userDataBox.get('isAdvisor');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                    .push(SlideLiftRoute(child: const AttendanceTaker()));
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
                // StaffTimeTable();
                Navigator.of(context)
                    .push(SlideLiftRoute(child: StaffTimeTable()));
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
            if (staffMode) const Expanded(child: SizedBox()),
            if (staffMode)
              GestureDetector(
                onTap: () {
                  print("My Class");
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
                          image: AssetImage('assets/home/staff/my-class.png'),
                          height: 40.0,
                        ),
                      ),
                      Text(
                        "My Class",
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
                print("About Me");
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
