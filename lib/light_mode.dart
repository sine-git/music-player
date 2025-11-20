import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.grey.shade900),
      bodyMedium: TextStyle(color: Colors.grey.shade900),
      bodySmall: TextStyle(color: Colors.grey.shade900),
    ),
    scaffoldBackgroundColor: Colors.grey.shade500,
    iconTheme: IconThemeData(color: Colors.grey.shade300),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade500,
        titleTextStyle: TextStyle(color: Colors.grey.shade300, fontSize: 20)),
    colorScheme: ColorScheme.light(
        surface: Colors.grey.shade300,
        inverseSurface: Colors.grey.shade900,
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade200,
        inversePrimary: Colors.grey.shade900));
