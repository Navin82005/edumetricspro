// ignore_for_file: prefer_const_constructors

import "package:edumetricspro/components/staff/menuDrawer.dart";
import "package:edumetricspro/services/services.stafftimetable.dart";
import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:shimmer/shimmer.dart";

class StaffTimeTable extends StatefulWidget {
  const StaffTimeTable({super.key});

  @override
  State<StaffTimeTable> createState() => _StaffTimeTableState();
}

class _StaffTimeTableState extends State<StaffTimeTable> {
  late Map localData;
  late Box userDataBox;
  bool loading = true;
  var staffName = '';
  var staffMode = false;
  String dropdown = '';
  int dateTimeNow = 0;
  int tempIndex = 0;
  bool isLoading = true;
  bool server_error = false;
  bool internal_server_error = false;

  var timeTableData = {
    "monday": [
      ["2 CSE - B", "OOPS", "08:30 - 9:30"],
      ["2 CSE - B", "OOPS", "10:50 - 11:50"],
      ["1 CSE - C", "CTPS", "3:45 - 4:35"],
    ],
    "tuesday": [
      ["2 CSE - B", "OOPS", "08:30 - 9:30"],
      ["2 CSE - B", "OOPS", "10:50 - 11:50"],
      ["1 CSE - C", "CTPS", "3:45 - 4:35"],
    ],
  };

  List<Map> tileData = [
    {"period": "Time", "color": Colors.green},
    {"period": "Monday", "color": Colors.green},
    {"period": "Tuesday", "color": Colors.green},
    {"period": "Wednesday", "color": Colors.green},
    {"period": "Thursday", "color": Colors.green},
    {"period": "Friday", "color": Colors.green},
    {"period": "Saturday", "color": Colors.green},
  ];

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
    });
    getLocalData();
  }

  void getLocalData() async {
    userDataBox = await Hive.openBox('userData');
    setState(() {
      dateTimeNow = DateTime.now().weekday;
      tempIndex = dateTimeNow;
      staffName = (userDataBox.get('name'));
      staffMode = userDataBox.get('isAdvisor');
    });
    var timetableData = await get_staff_timetable(staffName);
    // print(
    //   "timetableData : ${timetableData.containsKey("message")}; timetableData == ['Unable to get data'] : ${timetableData == [
    //         "Unable to get data"
    //       ]}",
    // );
    print(
        'timeTableData[message] = ${timetableData["message"].toString() == "[[Unable to process data]]"}');
    if (timetableData.containsKey("message")) {
      setState(
        () {
          if (timetableData["message"].toString() ==
              "[[Unable to process data]]") {
            server_error = false;
            internal_server_error = true;
          } else {
            server_error = true;
            internal_server_error = false;
          }
        },
      );
    } else {
      setState(() {
        print("timetableData: $timetableData");
        timeTableData = timetableData;
        server_error = false;
        internal_server_error = false;
      });
    }
    print(userDataBox.get('username'));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Time Table",
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
            child: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu_open),
              );
            }),
          )
        ],
      ),
      // StaffAppBar1(),
      drawer: const StaffMenu(),

      body: (isLoading)
          ? LiquidPullToRefresh(
              animSpeedFactor: 5,
              showChildOpacityTransition: false,
              color: Theme.of(context).colorScheme.primary,
              onRefresh: () => _refresh(),
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.onBackground,
                highlightColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: ListView(
                    children: ListLoaderDays(),
                  ),
                ),
              ),
            )
          : (server_error)
              ? LiquidPullToRefresh(
                  animSpeedFactor: 5,
                  showChildOpacityTransition: false,
                  color: Theme.of(context).colorScheme.primary,
                  onRefresh: () => _refresh(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: ListView(
                      children: [
                        Text(
                          "Unable to connect to the server. Make sure the device is connected to the internet",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : (internal_server_error)
                  ? LiquidPullToRefresh(
                      animSpeedFactor: 5,
                      showChildOpacityTransition: false,
                      color: Theme.of(context).colorScheme.primary,
                      onRefresh: () => _refresh(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: ListView(
                          children: [
                            Text(
                              "Unable to load data. Please try again later",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : LiquidPullToRefresh(
                      animSpeedFactor: 5,
                      showChildOpacityTransition: false,
                      color: Theme.of(context).colorScheme.primary,
                      onRefresh: () => _refresh(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: ListView(
                          children: ListTimeTable(),
                        ),
                      ),
                    ),
    );
  }

  ListTimeTable() {
    List<Widget> lst = [];
    print(server_error);
    try {
      for (var element in timeTableData.keys) {
        int i = 0;
        lst.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    element.toUpperCase(),
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        while (i < timeTableData[element]!.length) {
          print(timeTableData[element]![i]);
          lst.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.green[800],
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${i + 1} : ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.amber,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        timeTableData[element]![i][0].toUpperCase(),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                        ),
                      ),
                      Spacer(),
                      Text(
                        timeTableData[element]![i][1].toUpperCase(),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                        ),
                      ),
                      Spacer(),
                      Text(
                        timeTableData[element]![i][2].toUpperCase(),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          i++;
        }
        print(timeTableData[element]);
      }
    } catch (e) {
      print("Error in time_table: $e");
    }
    return lst;
  }

  ListLoaderDays() {
    List<Widget> lst = [];
    var days = [
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday",
    ];
    for (var element in days) {
      lst.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  element.toUpperCase(),
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    ;
    return lst;
  }
}
