import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/pages/student/student.timetable.dart';
import 'package:edumetricspro/services/logout.dart';
import 'package:edumetricspro/services/services.actions.dart';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({super.key});

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  String dropdown = '';
  bool repMode = true;
  String username = 'user';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('name') ?? 'user';
      repMode = prefs.getBool('isRep') ?? true;
    });
  }

  TextEditingController SearchTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            MenuHeader(),
            const Divider(
              thickness: 2,
              color: Colors.black87,
            ),
            Menu(),
          ],
        ),
      ),
    );
  }

  Widget MenuHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 5, 50, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
                const Spacer(),
                Image.asset(
                  "assets/home/student/profile.png",
                  width: 50,
                ),
              ],
            ),
          )
        ],
      );

  Widget Menu() => ListView(
        shrinkWrap: true,
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
                  child: const Text(
                    "Change Password",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, .5),
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
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, .5),
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
                  child: const Text(
                    "Change Profile Picture",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, .5),
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
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(SlideLiftRoute(child: const StudentTimetable()));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Time Table"),
            ),
          ),
          if (repMode)
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
                child: Text("Inform Faculty"),
              ),
            ),
          IconButton(
            tooltip: "Log out",
            onPressed: () {
              AuthService serv = AuthService(AppConfig.backendUrl);
              serv.logout();
              Logout.logout(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      );
}
