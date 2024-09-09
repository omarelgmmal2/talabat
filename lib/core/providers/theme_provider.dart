import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  static const themeStatus = "ThemeStatus";
  bool darkTheme = false;
  bool get getIsDarkTheme => darkTheme;

  ThemeProvider() {
    getTheme();
  }

  Future<void> setDarkTheme({required bool themeValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, themeValue);
    darkTheme = themeValue;
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    darkTheme = prefs.getBool(themeStatus) ?? false;
    notifyListeners();
    return darkTheme;
  }

}