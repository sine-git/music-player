import 'package:flutter/material.dart';
import 'package:music_player/dark_mode.dart';
import 'package:music_player/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  // get Theme
  ThemeData get themeData => _themeData;
  // is dark mode
  bool get isDarkMode => _themeData == darkMode;
  // set Theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    // update UI
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
  }
}
