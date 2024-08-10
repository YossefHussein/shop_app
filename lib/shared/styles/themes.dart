import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/colors.dart';

var lightTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'Cairo',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  // for app bar
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ),
    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0.0,
  ),
  // for text
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
    ),
  ),
  // for bottom nav
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.deepOrange,
  ),
  // for icon
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  buttonTheme: ButtonThemeData(buttonColor: defaultColor),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor, foregroundColor: Colors.white),
);

var darkTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'Cairo',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: pColor,
  // for text
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
    ),
  ),
  // for app bar
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: pColor,
      statusBarBrightness: Brightness.dark,
    ),
    color: pColor,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontFamily: 'ProtestRiot',
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    elevation: 0.0,
  ),
  // for icon
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  // for bottom nav
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: pColor,
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor, foregroundColor: Colors.white),
);
