import 'package:flutter/material.dart';
import 'package:offline_database/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  //Initial theme = light mode
  ThemeData _themeData = lightMode;

  // Method to access the theme from other parts of the code
  ThemeData get themeData => _themeData;

  // Method to check the theme of the app
  bool get isDarkMode => _themeData == darkMode;

  // Setting new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // Toggling the theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
