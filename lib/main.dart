// // ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:edumetricspro/pages/attendance/attendanceTaker.dart';
import 'package:edumetricspro/pages/home/adminHome.dart';
import 'package:edumetricspro/pages/home/staffHome.dart';
import 'package:edumetricspro/pages/home/studentHome.dart';
import 'package:edumetricspro/pages/login/adminLogin.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/pages/login/staffLogin.dart';
import 'package:edumetricspro/pages/login/studentLogin.dart';
import 'package:edumetricspro/pages/staff/time_table.dart';
import 'package:edumetricspro/pages/student/student.aboutMe.dart';
import 'package:edumetricspro/services/services.actions.dart';
import 'package:edumetricspro/theme/dark_theme.dart';
import 'package:edumetricspro/theme/light_theme.dart';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// void main() async {
//   await Hive.initFlutter();
//   Box loginBox = await Hive.openBox('Login');

//   // await loginBox.clear();

//   var isLogedin = loginBox.get('login');
//   var userType = loginBox.get('type');
//   print(
//       "Main File Refresh: ${loginBox.get('refresh')} isLogedin: $isLogedin userType: $userType");

//   Widget runapp = MainLogin();

//   if (isLogedin != null) {
//     if (userType == 'staff')
//       runapp = StaffHome();
//     else if (userType == 'admin')
//       runapp = AdminHome();
//     else if (userType == 'student') runapp = StudentHome();
//   } else if (isLogedin == null) {
//     runapp = MainLogin();
//   }

//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       debugShowMaterialGrid: false,
//       theme: lightTheme,
//       darkTheme: darkTheme,
//       routes: {
//         'mainlogin': (context) => MainLogin(),
//         'staffLogin': (context) => StaffLogin(),
//         'adminLogin': (context) => AdminLogin(),
//         'studentLogin': (context) => StudentLogin(),
//         'takeAttendance': (context) => AttendanceTaker(),
//       },
//       // home: StudentAbout(),
//       // home: AttendanceTaker(),
//       // home: StaffTimeTable(),
//       home: runapp,
//     ),
//   );
// }

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  var userType = prefs.getString('userType') ?? '';

  AuthService service = AuthService(AppConfig.backendUrl);
  late Map<String, dynamic> response = {"success": false};
  try {
    response = await service.checkAuthenticated();
  } catch (e) {
    print("Error main: $e");
  }

  print(
      "Main File Refresh: isLoggedIn: $isLoggedIn userType: $userType isUserVerified: $response");

  Widget runapp = MainLogin();

  if (isLoggedIn) {
    if (userType == 'staff')
      runapp = StaffHome();
    else if (userType == 'admin')
      runapp = AdminHome();
    else if (userType == 'student') runapp = StudentHome();
  } else {
    runapp = MainLogin();
  }

  if (response['success'] == true) {
  } else {
    runapp = MainLogin();
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: {
        'mainlogin': (context) => MainLogin(),
        'staffLogin': (context) => StaffLogin(),
        'adminLogin': (context) => AdminLogin(),
        'studentLogin': (context) => StudentLogin(),
        'takeAttendance': (context) => AttendanceTaker(),
      },
      home: runapp,
    ),
  );
}
