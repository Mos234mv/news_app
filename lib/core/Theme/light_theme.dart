import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/core/constant/app_sizes.dart';

ThemeData light = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  textTheme: TextTheme(
    displayMedium: TextStyle(
      color: Color(0xFF4E4B66),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      color: Color(0xFF6E7191),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: const Color.fromRGBO(197, 48, 48, 1),
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF363636),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      color: Color(0xFF141414),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0xFF363636),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: LightColor.primaryColor,
      fontSize: AppSizes.sp45,
      fontWeight: FontWeight.w700,
    ),

    bodyMedium: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w700,
    ),

    bodySmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
      decorationColor: Color(0xFFFFFCFC),
    ),
    headlineSmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(LightColor.primaryColor),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: AppSizes.sp14, fontWeight: FontWeight.w400),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColor.primaryColor,
      foregroundColor: Color(0xFFFFFCFC),
      textStyle: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400),
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
    hintStyle: TextStyle(
      color: Color(0xFF363636),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
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
      borderSide: BorderSide(color: Colors.red, width: AppSizes.w0_5),
    ),
  ),

  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.red),
  appBarTheme: AppBarThemeData(
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w700,
      color: Color(0xFF141414),
    ),
  ),
);
