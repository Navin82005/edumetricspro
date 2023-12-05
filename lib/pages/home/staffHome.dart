import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/components/staff/menuDrawer.dart';
import 'package:edumetricspro/pages/attendance/attendanceTaker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({super.key});

  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  late Map localData;
  late Box userDataBox;
  bool loading = true;
  var staffName = '';
  var staffMode = false;
  String dropdown = '';

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    userDataBox = await Hive.openBox('userData');
    setState(() {
      staffName = (userDataBox.get('name'));
      staffMode = userDataBox.get('isAdvisor');
      loading = false;
    });
    print(userDataBox.get('username'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              staffName.toString(),
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      drawer: const StaffMenu(),
      body: (loading)
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white70,
              enabled: true,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            child: Container(
                              height: 100,
                              width: double.maxFinite,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    (BorderRadius.all(Radius.circular(10.0))),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange,
                                    Colors.orangeAccent,
                                    Colors.red,
                                    Colors.redAccent
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/home/staff/attendance.png'),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
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
                        Navigator.of(context).push(
                            SlideLiftRoute(child: const AttendanceTaker()));
                      },
                      child: Container(
                        height: 100,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          borderRadius:
                              (BorderRadius.all(Radius.circular(10.0))),
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
                                image: AssetImage(
                                    'assets/home/staff/attendance.png'),
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
                        print("Viewing Timetable");
                      },
                      child: Container(
                        height: 100,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          borderRadius:
                              (BorderRadius.all(Radius.circular(10.0))),
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
                                image: AssetImage(
                                    'assets/home/staff/time-table.png'),
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
                            borderRadius:
                                (BorderRadius.all(Radius.circular(10.0))),
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
                                  image: AssetImage(
                                      'assets/home/staff/my-class.png'),
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
                          borderRadius:
                              (BorderRadius.all(Radius.circular(10.0))),
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
                                image: AssetImage(
                                    'assets/home/staff/about-me.png'),
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
            ),
    );
  }
}
