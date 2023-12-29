import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/components/staff/menuDrawer.dart';
import 'package:edumetricspro/pages/attendance/attendanceTaker.dart';
import 'package:edumetricspro/pages/home/staff.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/pages/staff/time_table.dart';
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
  late Box loginDataBox;
  bool loading = true;
  var staffName = '';
  var staffMode = false;
  String dropdown = '';
  int _bottomNavSelectedIndex = 0;
  bool isLogged = true;

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  List<Widget> screens = [
    StaffHomeContent(),
    StaffTimeTable(),
  ];

  void getLocalData() async {
    userDataBox = await Hive.openBox('userData');
    loginDataBox = await Hive.openBox('Login');
    if (loginDataBox.get('login') == false) {
      Navigator.pop(context);
      Navigator.of(context).push(SlideLiftRoute(child: const MainLogin()));
      print("Not Logged in");
    } else {
      setState(() {
        isLogged = true;
      });
    }
    setState(() {
      staffName =
          (userDataBox.get('name')) == null ? '' : userDataBox.get('name');
      staffMode = userDataBox.get('isAdvisor');
      loading = false;
    });
    print("username:  ${userDataBox.get('username')}");

    // if (isLogged == false) {
    //   Navigator.pop(context);
    //   Navigator.of(context).push(SlideLiftRoute(child: const MainLogin()));
    //   print("Not Logged in");
    // }
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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
            ),
          ),
        ),
        child: NavigationBar(
          height: 50.0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _bottomNavSelectedIndex,
          onDestinationSelected: (index) => setState(() {
            _bottomNavSelectedIndex = index;
          }),
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home_filled),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.calendar_month),
              icon: Icon(
                Icons.calendar_month_outlined,
              ),
              label: "Time Table",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.view_list),
              icon: Icon(
                Icons.view_list_outlined,
              ),
              label: "My Class",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(
                Icons.person_outline,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
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
          : screens[_bottomNavSelectedIndex],
    );
  }
}
