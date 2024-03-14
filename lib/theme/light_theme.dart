import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  colorScheme:  ColorScheme.light(
    background: Colors.grey.shade100,
    primaryContainer: Colors.grey.shade300,
    secondary: Colors.grey.shade300,
    tertiary: Colors.white,
    secondaryContainer: Colors.grey.shade900,

    brightness: Brightness.light,
    onSecondaryContainer: Colors.grey.shade300,
  ),
  


);
