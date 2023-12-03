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
  var staffName;
  var staffMode;

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
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              staffName.toString(),
            ),
          ),
        ],
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
                      child: const Text(
                        "Attendance",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
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
                      child: const Text("Time Table"),
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
                        child: const Text("My Class"),
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
                      child: const Text("About Me"),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
    );
  }
}
