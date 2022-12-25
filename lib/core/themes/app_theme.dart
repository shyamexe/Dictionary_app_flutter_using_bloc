import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
      primarySwatch: Colors.teal,
      backgroundColor: const Color(0XFFB8DFD8),
      primaryColor: const Color(0XFF4C4C6D),
      canvasColor: const Color(0xffB8DFD8),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0XFFE8F6EF),
      textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 15.sp.sp,
            color: const Color(0xff50577A),
          ),
          headline2: TextStyle(
            fontSize: 20.sp,
            color: const Color(0xff50577A),
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(fontSize: 14.sp, color: const Color(0xff50577A)),
          bodyText2: TextStyle(fontSize: 12.sp, color: const Color(0xff50577A)),
          headline6: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff50577A))));

  static final darkTheme = ThemeData(
      primarySwatch: Colors.teal,
      backgroundColor: const Color(0XFF50577A),
      primaryColor: Colors.white,
      canvasColor: const Color(0xff50577A),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0XFF404258),
      textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xffE8F6EF),
          ),
          headline2: TextStyle(
            fontSize: 20.sp,
            color: const Color(0xffE8F6EF),
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(fontSize: 14.sp, color: const Color(0xffE8F6EF)),
          bodyText2: TextStyle(fontSize: 12.sp, color: const Color(0xffE8F6EF)),
          headline6: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xffE8F6EF))));
}
