import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles{
  static ThemeData themeData(bool isDark, BuildContext context){
    return ThemeData(
      scaffoldBackgroundColor: isDark? Colors.black: Colors.grey.shade100,
      primaryColor: Colors.cyan,
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary: isDark?Colors.deepPurple.shade400.withOpacity(0.8): Colors.deepPurple.shade100.withOpacity(0.8),
        brightness: isDark? Brightness.dark :Brightness.light
      ),
      cardColor: isDark? Colors.white: Colors.grey,
      canvasColor: isDark? Colors.grey.shade500: Colors.grey.shade300,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isDark? ColorScheme.dark():ColorScheme.light()
      )

    );
  }
}