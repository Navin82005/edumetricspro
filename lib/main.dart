// ignore_for_file: prefer_const_constructors

import 'package:edumetricspro/components/EduAppBar.dart';
import 'package:edumetricspro/pages/login/student.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: StudentLogin(),
    ),
  );
}
