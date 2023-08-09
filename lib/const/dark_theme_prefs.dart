import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs{
  static const Theme_status="Theme_status";
  setDarkTheme(bool value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance() ;
    preferences.setBool(Theme_status, value);
  }
  getDarkTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance() ;
    preferences.getBool(Theme_status)?? false;
  }
}