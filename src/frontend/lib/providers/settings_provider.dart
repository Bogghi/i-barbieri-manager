import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Brightness _darkMode = Brightness.light;

  SettingsProvider();

  Brightness getMode() {
    return _darkMode;
  }

  void changeMode() {
    _darkMode = _darkMode == Brightness.dark ? Brightness.light : Brightness.dark;
    notifyListeners();
  }
}