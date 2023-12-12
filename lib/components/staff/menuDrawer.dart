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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    Box userDataBox = await Hive.openBox('userData');
    setState(() {
      staffName = (userDataBox.get('name'));
      staffMode = userDataBox.get('isAdvisor');
    });
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
        ],
      ),
    );
  }
}