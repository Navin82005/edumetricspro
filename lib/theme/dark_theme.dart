import "package:flutter/material.dart";

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white,
    secondary: Colors.white60,
    tertiary: Color.fromARGB(255, 30, 30, 30),
    error: Color.fromRGBO(119, 67, 219, 1),
    onBackground: Color.fromRGBO(119, 67, 219, .5),
  ),
);
