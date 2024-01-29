import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/pages/student/student.timetable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
    setState(() {
      username = userDataBox.get('name');
    });
    loginDataBox = await Hive.openBox('login');
    setState(() {
      repMode = userDataBox.get('isRep');
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
            // SearchBarAnimation(
            //   textEditingController: SearchTextEditController,
            //   isOriginalAnimation: false,
            //   trailingWidget: const Icon(Icons.search),
            //   secondaryButtonWidget: const Icon(Icons.search_off),
            //   buttonColour: Colors.amber,
            //   buttonBorderColour: Colors.green,
            //   buttonElevation: 0,
            //   buttonShadowColour: Colors.blue,
            //   cursorColour: Colors.deepOrange,
            //   durationInMilliSeconds: 200,
            //   buttonWidget: const Icon(Icons.search),
            //   onFieldSubmitted: (String value) {
            //     print("Value: $value");
            //     print(SearchTextEditController.text);
            //   },
            // ),
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
                // Container(
                //   height: 10,
                //   width: double.maxFinite,
                //   color: Colors.black26,
                // )
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
                      // backgroundColor: Color.fromRGBO(50, 50, 50, 1),
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
                      // backgroundColor: Color.fromRGBO(50, 50, 50, 1),
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
                      // backgroundColor: Color.fromRGBO(50, 50, 50, 1),
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
          // TextButton(
          //   style: ButtonStyle(
          //     shape: MaterialStateProperty.all<OutlinedBorder>(
          //       const BeveledRectangleBorder(),
          //     ),
          //   ),
          //   onPressed: () {},
          //   child: const Padding(
          //     padding: EdgeInsets.symmetric(vertical: 10.0),
          //     child: Text("View Current Slot"),
          //   ),
          // ),
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
            onPressed: () => _logout(),
            icon: const Icon(Icons.logout),
          )
        ],
      );
}
