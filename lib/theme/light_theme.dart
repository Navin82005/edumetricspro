import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromRGBO(119, 67, 219, 1),
    primary: Color.fromRGBO(247, 239, 229, 1),
    secondary: Color.fromRGBO(119, 67, 219, 1),
    tertiary: Color.fromRGBO(175, 175, 175, 1),
    error: Colors.red,
    onBackground: Color.fromRGBO(119, 67, 219, .5),
    surface: Color.fromRGBO(119, 67, 219, 1),
  ),
);
