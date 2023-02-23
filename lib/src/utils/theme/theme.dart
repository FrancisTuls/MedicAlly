import 'package:flutter/material.dart';
import '../../constants/color_schemes.dart';

class MedicAppTheme {
  static ThemeData lightTheme = ThemeData(
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: lightColorScheme);
  static ThemeData darkTheme = ThemeData(
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: darkColorScheme);
}
