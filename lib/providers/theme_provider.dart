import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData themeData = ThemeData.dark();

  void toggleThemeMode() {
    if (themeData.brightness == Brightness.light) {
      themeData = ThemeData.dark();
    } else {
      themeData = ThemeData.light();
    }
    notifyListeners();
  }
}
