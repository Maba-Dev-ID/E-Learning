import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  String? currentTheme = 'system';

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  getCurrentTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentTheme = prefs.getString('theme') ?? 'system';
    notifyListeners();
    return currentTheme;
  }

  changeTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
    currentTheme = theme;
    notifyListeners();
  }
}
