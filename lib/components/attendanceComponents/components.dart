import 'package:flutter/material.dart';

class AttendanceCheckBox extends StatefulWidget {
  final bool isChecked;
  const AttendanceCheckBox({super.key, required this.isChecked});

  @override
  State<AttendanceCheckBox> createState() => _AttendanceCheckBoxState();
}

class _AttendanceCheckBoxState extends State<AttendanceCheckBox> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (newbool) {
        setState(() {
          isChecked = newbool;
        });
      },
    );
  }
}
