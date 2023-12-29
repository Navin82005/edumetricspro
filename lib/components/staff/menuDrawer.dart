import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StaffMenu extends StatefulWidget {
  const StaffMenu({super.key});

  @override
  State<StaffMenu> createState() => _StaffMenuState();
}

class _StaffMenuState extends State<StaffMenu> {
  String dropdown = '';
  bool staffMode = false;
  String staffName = 'user';
  late Box userDataBox;
  late Box loginDataBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    userDataBox = await Hive.openBox('userData');
    loginDataBox = await Hive.openBox('login');
    setState(() {
      staffName = (userDataBox.get('name'));
      staffMode = userDataBox.get('isAdvisor');
    });
  }

  void _logout() {
    loginDataBox.put('type', null);
    loginDataBox.put('login', false);
    loginDataBox.put('refresh', null);

    userDataBox.put('name', null);
    userDataBox.put('username', null);
    userDataBox.put('isAdvisor', false);

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.of(context).push(SlideLiftRoute(child: const MainLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
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
                  child: const Center(
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
                  child: const Center(
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
                  child: const Center(
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
                  child: const Center(
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
                  child: const Center(
                    child: Text(
                      "Change Attendance",
                      style:
                          TextStyle(color: Color.fromRGBO(255, 255, 255, .5)),
                    ),
                  ),
                ),
              ],
            ),
          IconButton(
            onPressed: () => _logout(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}

// App-Bar
class StaffAppBar extends StatefulWidget {
  final String heading;
  final Widget sCaffold;
  const StaffAppBar({Key? mykey, required this.heading, required this.sCaffold})
      : super(key: mykey);

  @override
  State<StaffAppBar> createState() => _StaffAppBarState();
}

class _StaffAppBarState extends State<StaffAppBar> {
  late Box userDataBox;
  var staffName = '';
  var staffMode = false;

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    userDataBox = await Hive.box('userData');
    setState(() {
      staffName = userDataBox.get('name');
      staffMode = userDataBox.get('isAdvisor');
    });
    print(userDataBox.get('username'));
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold();
    return AppBar(
      elevation: 0.0,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        // widget.heading,
        widget.heading,
        style: const TextStyle(
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
        Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              print(widget.sCaffold);
            },
            icon: const Icon(Icons.menu_open),
            padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
          );
        })
      ],
    );
  }
}
