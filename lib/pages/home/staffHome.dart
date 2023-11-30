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

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    // setState(() {
    //   loading = false;
    // });
    userDataBox = await Hive.openBox('userData');
    staffName = userDataBox.get('name');
    print(userDataBox.get('username'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EduMatricsPro",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              staffName,
            ),
          ),
        ],
      ),
      body: (loading)
          ? Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Lottie.asset('assets/loaders/blueCircleLoader.json'),
              ),
            )
          : null,
    );
  }
}
