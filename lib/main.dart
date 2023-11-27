// ignore_for_file: prefer_const_constructors

import 'package:edumetricspro/components/EduAppBar.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/pages/login/staffLogin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routes: {
        'mainlogin': (context) => MainLogin(),
        'staffLogin': (context) => StaffLogin(),
      },
      home: MainLogin(),
    ),
  );
}
