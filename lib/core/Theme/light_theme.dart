import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';

ThemeData light = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  textTheme: TextTheme(
    displayMedium: TextStyle(color: Color(0xFF4E4B66), fontSize: 20, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(color: Color(0xFF6E7191), fontSize: 16, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(color: const Color.fromRGBO(197, 48, 48, 1), fontSize: 14, fontWeight: FontWeight.w400),
    titleMedium: TextStyle(color: Color(0xFF363636), fontSize: 20, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(color: Color(0xFF141414), fontSize: 16, fontWeight: FontWeight.w400),
    displayLarge: TextStyle(color: Color(0xFF363636), fontSize: 16, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(color: LightColor.primaryColor, fontSize: 45, fontWeight: FontWeight.w700),

    bodyMedium: TextStyle(color: Color(0xFFFFFCFC), fontSize: 16, fontWeight: FontWeight.w700),

    bodySmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
      decorationColor: Color(0xFFFFFCFC),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(LightColor.primaryColor),
      textStyle: WidgetStateProperty.all(TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
    ), //TextButton.styleFrom(foregroundColor: Color(0xFFC53030)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColor.primaryColor,
      foregroundColor: Color(0xFFFFFCFC),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    selectedItemColor: LightColor.primaryColor,
    unselectedItemColor: Color(0xFF363636),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Color(0xFF363636), fontSize: 16, fontWeight: FontWeight.w400),
    filled: true,
    focusColor: Color(0xffD1DAD6),
    fillColor: const Color(0xFFFFFFFF),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.red),
  appBarTheme: AppBarThemeData(
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF141414)),
  ),
);
