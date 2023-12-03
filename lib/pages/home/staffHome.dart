import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

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
      staffMode = userDataBox.get('isAdvisor') == '1' ? true : false;
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
      drawer: Drawer(
        child: ListView(
          children: [
            // const Expanded(child: SizedBox()),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const BeveledRectangleBorder(),
                ),
              ),
              onPressed: () {
                setState(
                  () {
                    if (dropdown == 'about-me') {
                      dropdown = '';
                    } else {
                      dropdown = 'about-me';
                    }
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("About Me"),
              ),
            ),
            if (dropdown == 'about-me')
              Column(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const BeveledRectangleBorder(),
                      ),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, .5),
                          // backgroundColor: Color.fromRGBO(50, 50, 50, 1),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const BeveledRectangleBorder(),
                      ),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, .5),
                          // backgroundColor: Color.fromRGBO(50, 50, 50, 1),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const BeveledRectangleBorder(),
                      ),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Change Profile Picture",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, .5),
                          // backgroundColor: Color.fromRGBO(50, 50, 50, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const BeveledRectangleBorder(),
                ),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Take Attendance"),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const BeveledRectangleBorder(),
                ),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("View Current Slot"),
              ),
            ),
            if (staffMode)
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const BeveledRectangleBorder(),
                  ),
                ),
                onPressed: () {
                  setState(
                    () {
                      if (dropdown == 'my-class') {
                        dropdown = '';
                      } else {
                        dropdown = 'my-class';
                      }
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("My Class"),
                ),
              ),
            if (dropdown == 'my-class')
              Column(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const BeveledRectangleBorder(),
                      ),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "See Students",
                        style:
                            TextStyle(color: Color.fromRGBO(255, 255, 255, .5)),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const BeveledRectangleBorder(),
                      ),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Change Attendance",
                        style:
                            TextStyle(color: Color.fromRGBO(255, 255, 255, .5)),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      body: (loading)
          ? Scaffold(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              body: Center(
                child: Lottie.asset('assets/loaders/blueCircleLoader.json'),
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
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        borderRadius: (BorderRadius.all(Radius.circular(10.0))),
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
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        borderRadius: (BorderRadius.all(Radius.circular(10.0))),
                        gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.greenAccent,
                            Colors.teal,
                            Colors.tealAccent,
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
                        ],
                      ),
                    ),
                    if (staffMode) const Expanded(child: SizedBox()),
                    if (staffMode)
                      Container(
                        height: 100,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          borderRadius:
                              (BorderRadius.all(Radius.circular(10.0))),
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink,
                              Colors.pinkAccent,
                              Colors.deepPurple,
                              Colors.deepPurpleAccent,
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
                          ],
                        ),
                      ),
                    const Expanded(child: SizedBox()),
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        borderRadius: (BorderRadius.all(Radius.circular(10.0))),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.blueAccent,
                            Colors.lightBlue,
                            Colors.lightBlueAccent,
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
                              image:
                                  AssetImage('assets/home/staff/about-me.png'),
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
                        ],
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
