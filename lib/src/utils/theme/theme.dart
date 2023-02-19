import 'package:flutter/material.dart';

class MedicAppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
      fontFamily: 'Poppins', brightness: Brightness.dark, useMaterial3: true);
}
