import 'package:flutter/material.dart';

class ThemeModes {
  static ThemeData darkMode() {
    return ThemeData(
      primarySwatch: Colors.teal,
      // primaryColor: ,
      brightness: Brightness.dark,
      accentColor: Colors.tealAccent,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
      appBarTheme: AppBarTheme(
        foregroundColor: ThemeData.dark().accentColor,
        titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ThemeData.dark().accentColor),
      ),
    );
  }

  static ThemeData lightMode() {
    return ThemeData(
      primarySwatch: Colors.teal,
      // primaryColor: ,
      brightness: Brightness.light,
      accentColor: Colors.teal,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: "OpenSans",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
