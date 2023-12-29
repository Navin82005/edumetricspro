// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:edumetricspro/pages/attendance/attendanceTaker.dart';
import 'package:edumetricspro/pages/home/adminHome.dart';
import 'package:edumetricspro/pages/home/staffHome.dart';
import 'package:edumetricspro/pages/home/studentHome.dart';
import 'package:edumetricspro/pages/login/adminLogin.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/pages/login/staffLogin.dart';
import 'package:edumetricspro/pages/login/studentLogin.dart';
import 'package:edumetricspro/pages/staff/time_table.dart';
import 'package:edumetricspro/theme/dark_theme.dart';
import 'package:edumetricspro/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Box loginBox = await Hive.openBox('Login');

  // await loginBox.clear();

  var isLogedin = loginBox.get('login');
  var userType = loginBox.get('type');
  print("Refresh: ${loginBox.get('refresh')}");

  late var runapp;

  if (isLogedin != null) {
    if (userType == 'staff')
      runapp = StaffHome();
    else if (userType == 'admin')
      runapp = AdminHome();
    else if (userType == 'student') runapp = StudentHome();
  } else if (isLogedin == null) {
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
      // home: AttendanceTaker(),
      // home: StaffTimeTable(),
      home: runapp,
    ),
  );
}
