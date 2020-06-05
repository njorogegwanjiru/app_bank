import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textSelectionHandleColor: Color(0xFF29304d),
    textSelectionColor: Color(0xFFbbe1fa),
    cursorColor: Color(0xFF29304d),
    toggleableActiveColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Color(0xFF29304d),
      iconTheme: IconThemeData(
        color: Color(0xFFbbe1fa),
      ),
      textTheme: TextTheme(
        display2: TextStyle(
          color: Color(0xFFffffff),
          fontSize: 18.0,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        suffixStyle: TextStyle(color: Colors.black),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15)),
    colorScheme: ColorScheme.light(
        primary: Color(0xFFbbe1fa),
        onPrimary: Colors.white,
        primaryVariant: Color(0xff0f4c75),
        secondary: Colors.black,
        secondaryVariant: Color(0xFF3282b8),
        surface: Color(0xFF29304d),
        onSecondary: Colors.grey),
    cardTheme: CardTheme(
      color: Colors.white70,
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF29304d),
    ),
    textTheme: TextTheme(
        headline: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
        title: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        subtitle: TextStyle(
          color: Color(0xFF29304d),
          fontSize: 18.0,
        ),
        subhead: TextStyle(
          color: Colors.blue,
          fontSize: 16.0,
        ),
        body1: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        body2: TextStyle(
          color: Color(0xFF29304d),
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
        ),
        display1: TextStyle(
          color: Color(0xFFbbe1fa),
          fontSize: 16.0,
        ),
        display2: TextStyle(
          color: Color(0xFF000000),
          fontSize: 18.0,
        ),
        display3: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
        display4: TextStyle(
            color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold)),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}
