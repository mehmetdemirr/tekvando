import 'package:tekvando/core/cache/shared_pref.dart';
import 'package:tekvando/core/theme/dark_theme.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeNotifier(this._themeData);
  ThemeData _themeData;

  bool getTheme() => _themeData == darkTheme;

  Future<void> setTheme(ThemeData themeData) async {
    _themeData = themeData;
    final deger = getTheme();
    await SharedPref().setTheme(deger);
    notifyListeners();
  }
}
