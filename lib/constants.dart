import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.purple, // Use the desired shade of purple
  scaffoldBackgroundColor: const Color(0xFF21084A), // Dark purple for background
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white), // White text for readability
    bodyText2: TextStyle(color: Colors.white70), // Lighter white for secondary text
    headline6: TextStyle(color: Colors.white, fontSize: 18.0), // Headings
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF21084A), // Match background color
    iconTheme: IconThemeData(color: Colors.white), // White icons for contrast
  ),
  iconTheme: const IconThemeData(color: Colors.white), // White icons overall
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white), // White text
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.purple), // Purple button color
      foregroundColor: MaterialStateProperty.all(Colors.white), // White text
    ),
  ),
);
