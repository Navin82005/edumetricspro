import 'package:edumetricspro/components/profile.card.dart';
import 'package:edumetricspro/services/staff.class.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:hive/hive.dart';

class StaffMyClass extends StatefulWidget {
  const StaffMyClass({Key? key}) : super(key: key);

  @override
  State<StaffMyClass> createState() => _StaffMyClassState();
}

class _StaffMyClassState extends State<StaffMyClass> {
  String staffName = "staff";
  String staffClass = "2 CSE";
  dynamic allStudents = [];
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    Box userData = await Hive.openBox("userData");

    setState(() {
      staffName = userData.get("name");
      staffClass = userData.get("lectureHall");
    });

    var temp = await getStaffClassStudents(staffClass);
    setState(() {
      allStudents = temp;
    });
  }

  Future<void> _refresh() async {
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "My Class",
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              staffClass.toString(),
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        animSpeedFactor: 5.0,
        showChildOpacityTransition: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: ListView(
            children: RenderStudents(),
          ),
        ),
      ),
    );
  }

  List<Widget> RenderStudents() {
    List<Widget> lst = [];
    for (var element in allStudents) {
      lst.add(
        ProfileCard(
          profileImageUrl:
              "https://cdn-icons-png.flaticon.com/512/2919/2919906.png",
          name: element['name'],
          rollNumber: element['rollNo'],
          isActive: element['isActive'],
        ),
      );
    }
    return lst;
  }
}
