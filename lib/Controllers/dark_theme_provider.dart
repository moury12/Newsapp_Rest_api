import 'package:flutter/cupertino.dart';
import 'package:news_app/const/dark_theme_prefs.dart';

class DarkThemeProvider with ChangeNotifier{
  DarkThemePrefs darkThemePrefs =DarkThemePrefs();
  bool darkTheme = true;
  bool get getDarktheme => darkTheme;
  set setDarkTheme(bool value){
    darkTheme =value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}