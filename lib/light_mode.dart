import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade500,
    iconTheme: IconThemeData(color: Colors.grey.shade300),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade500,
        titleTextStyle: TextStyle(color: Colors.grey.shade300, fontSize: 20)),
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade300,
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade200,
        inversePrimary: Colors.grey.shade900));
