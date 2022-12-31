import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
      primarySwatch: Colors.teal,
      backgroundColor: const Color(0XFFB8DFD8),
      primaryColor: const Color(0XFF4C4C6D),
      canvasColor: const Color(0xffB8DFD8),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      //ripple color as focus color
      focusColor: Colors.teal[300]!,
      hoverColor: Colors.teal[100]!,
      //active color as focus color
      //tabBackgroundColor as bottomAppBarColor
      bottomAppBarColor: Colors.grey[100]!,
      scaffoldBackgroundColor: const Color(0XFFE8F6EF),
      textTheme: TextTheme(
          headline1: GoogleFonts.rajdhani(
            fontSize: 15,
            color: const Color(0xff50577A),
          ),
          headline2: GoogleFonts.rajdhani(
            fontSize: 20,
            color: const Color(0xff50577A),
            fontWeight: FontWeight.bold,
          ),
          bodyText1: GoogleFonts.rajdhani(fontSize: 14, color: const Color(0xff50577A)),
          bodyText2: GoogleFonts.rajdhani(fontSize: 12, color: const Color(0xff50577A)),
          headline6: GoogleFonts.rajdhani(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xff50577A))));

  static final darkTheme = ThemeData(
      primarySwatch: Colors.teal,
      backgroundColor: const Color(0XFF50577A),
      primaryColor: Colors.white,
      canvasColor: const Color(0xff50577A),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0XFF404258),
      //ripple color as focus color
      focusColor: Colors.black26,
      hoverColor: Colors.black12,
      //active color as focus color
      //tabBackgroundColor as bottomAppBarColor
      bottomAppBarColor: Colors.white10,
      textTheme: TextTheme(
          headline1: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: const Color(0xffE8F6EF),
          ),
          headline2: GoogleFonts.rajdhani(
            fontSize: 20,
            color: const Color(0xffE8F6EF),
            fontWeight: FontWeight.bold,
          ),
          bodyText1: GoogleFonts.rajdhani(fontSize: 14, color: const Color(0xffE8F6EF)),
          bodyText2: GoogleFonts.rajdhani(fontSize: 12, color: const Color(0xffE8F6EF)),
          headline6: GoogleFonts.rajdhani(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xffE8F6EF))));
}
