import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SemMarks extends StatefulWidget {
  final String sem;
  const SemMarks({super.key, required this.sem});

  @override
  State<SemMarks> createState() => _SemMarksState();
}

class _SemMarksState extends State<SemMarks> {
  late Box userDataBox;
  String studentName = "";

  Map semMap = {
    "sem 1": ["SEM 1", "SEM 2"],
    "sem 2": ["SEM 3", "SEM 4"],
    "sem 3": ["SEM 5", "SEM 6"],
    "sem 4": ["SEM 7", "SEM 8"],
  };

  // List semExams = [
  //   "IIT 1",
  //   "IIT 2",
  //   "IIT 3",
  // ];

  int subjects = 7;
  List semSubjects = ["ADSA", "OOPS", "DBMS", "MPMC", "DM", "BCE", "Tamil"];
  Map semExams = {
    0: [20, 60, 70, 49, 100, 80, 90],
    1: [48, 90, 75, 85, 95, 70, 90],
    2: [90, 60, 70, 80, 45, 80, 90],
  };

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
    // print(IITMarks());
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: IITMarks(),
      ),
    );
  }

  Widget IITMarks() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => print(index),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Internal Exam 0${index + 1}",
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
            ),
            MarkListView(index),
          ],
        ),
      ),
    );
  }

  Widget MarkListView(int mainIndex) {
    return Column(
      children: [
        for (int index = 0; index < subjects; index++)
          GestureDetector(
            onTap: () {},
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
                      semSubjects[index],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: semExams[mainIndex][index] >= 50
                            ? Colors.white
                            : Colors.red,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      semExams[mainIndex][index].toString(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: semExams[mainIndex][index] >= 50
                            ? Colors.white
                            : Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  // const Icon(Icons.navigate_next),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
