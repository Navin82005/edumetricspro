// ignore_for_file: prefer_const_constructors

import 'package:edumetricspro/components/EduAppBar.dart';
import 'package:edumetricspro/pages/login/adminLogin.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/pages/login/staffLogin.dart';
import 'package:edumetricspro/theme/dark_theme.dart';
import 'package:edumetricspro/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
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
      },
      home: MainLogin(),
    ),
  );
}
