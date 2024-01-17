import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentMarkSheet extends StatefulWidget {
  const StudentMarkSheet({super.key});

  @override
  State<StudentMarkSheet> createState() => _StudentMarkSheetState();
}

class _StudentMarkSheetState extends State<StudentMarkSheet> {
  late Box userDataBox;
  String studentName = "";
  bool currentYear = true;
  Map years = {
    "Year 1": {
      "IIT": ["1", "2", "3"],
      "SEM": ["01", "02"]
    }
  };
  List year = ["Year 1", "Year 2"];

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    userDataBox = await Hive.openBox('userData');
    setState(() {
      studentName = userDataBox.get('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
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
              studentName.toString(),
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Add any other widgets you want in the column here
            Expanded(
              child: IITMarks(),
            ),
          ],
        ),
      ),
    );
  }

  Widget IITMarks() {
    return ListView.builder(
      itemCount: year.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          // Add your navigation logic here
        },
        child: Container(
          height: 40.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromRGBO(0, 0, 0, 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (year[index]).toString(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
              if (currentYear)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    // Access the nested map value using the current year
                    "<- Current Year",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              const Spacer(),
              const Icon(Icons.navigate_next),
            ],
          ),
        ),
      ),
    );
  }
}
