import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.grey.shade300),
        bodyMedium: TextStyle(color: Colors.grey.shade300),
        bodySmall: TextStyle(color: Colors.grey.shade300)),
    scaffoldBackgroundColor: Colors.grey.shade900,
    iconTheme: IconThemeData(color: Colors.grey.shade300),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
        titleTextStyle: TextStyle(color: Colors.grey.shade300, fontSize: 20)),
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade900,
        primary: Colors.grey.shade600,
        secondary: Colors.grey.shade800,
        inversePrimary: Colors.grey.shade300));
