import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromRGBO(119, 67, 219, 1),
    primary: Color.fromRGBO(247, 239, 229, 1),
    secondary: Color.fromRGBO(119, 67, 219, 1),
    tertiary: Colors.transparent,
    error: Colors.red,
  ),
);
