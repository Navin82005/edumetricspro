import "package:flutter/material.dart";

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white,
    secondary: Colors.white60,
    tertiary: Color.fromARGB(150, 0, 0, 0),
    error: Color.fromRGBO(195, 172, 208, 1),
    onBackground: Color.fromRGBO(119, 67, 219, .5),
  ),
);
