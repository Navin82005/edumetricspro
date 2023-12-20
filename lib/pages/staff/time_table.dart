// ignore_for_file: prefer_const_constructors

import "package:edumetricspro/components/staff/menuDrawer.dart";
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

  var timeTableData = [
    // "Monday",
    // "Tuesday",
    // "Wednesday",
    // "Thursday",
    // "Friday",
    " ",
    "2 CSE - B (OOPS)\n8:30-9:30",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    "2 CSE - B (OOPS)\n10:50-11:50",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    "2 CSE - B (OOPS)",
    " ",
    " ",
    "2 CSE - B (OOPS)",
    " ",
    " ",
    "2 CSE - B (OOPS)",
    " ",
    " ",
    "2 CSE - B (OOPS)",
    "2 CSE - B (OOPS)",
    " ",
    " ",
    "2 CSE - B (OOPS)",
    " ",
    " ",
  ];

  List<Map> tileData = [
    {"period": "Monday", "color": Colors.green},
    {"period": "Tuesday", "color": Colors.green},
    {"period": "Wednesday", "color": Colors.green},
    {"period": "Thursday", "color": Colors.green},
    {"period": "Friday", "color": Colors.green},
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
      loading = false;
    });
    SetTileData(dateTimeNow, timeTableData);
    print(userDataBox.get('username'));

    setState(() {
      isLoading = false;
    });
  }

  void SetTileData(int today, List<String> tiles) {
    tempIndex = dateTimeNow;
    for (int i = 0; i < tiles.length; i++) {
      var period = tiles[i];
      tileData.add(
          {"period": period, "color": Theme.of(context).colorScheme.surface});

      if (tileData[i + 5]['period'] == " ") {
        if (tempIndex == i + 1) {
          tileData[i + 5]['color'] = Colors.green;
          tempIndex += 5;
        } else {
          tileData[i + 5]['color'] = Theme.of(context).colorScheme.surface;
        }
      } else {
        if (tempIndex == i + 1) {
          tempIndex += 5;
        }
        tileData[i + 5]['color'] = Theme.of(context).colorScheme.onBackground;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,

      drawer: const StaffMenu(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
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
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_open),
              padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
            );
          })
        ],
      ),
      // StaffAppBar1(),

      body: (isLoading)
          ? LiquidPullToRefresh(
              animSpeedFactor: 5,
              showChildOpacityTransition: false,
              color: Theme.of(context).colorScheme.primary,
              onRefresh: () => _refresh(),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade50,
                highlightColor: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: GridView.builder(
                    itemCount: 35,
                    padding: EdgeInsets.all(20.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                      mainAxisExtent: 140.0,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.purple,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                "pass",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : LiquidPullToRefresh(
              animSpeedFactor: 5,
              showChildOpacityTransition: false,
              color: Theme.of(context).colorScheme.primary,
              onRefresh: () => _refresh(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: GridView.builder(
                  itemCount: timeTableData.length,
                  padding: EdgeInsets.all(20.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                    mainAxisExtent: 140.0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: tileData[index]['color'],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              tileData[index]['period'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
