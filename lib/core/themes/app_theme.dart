import 'package:flutter/material.dart';
import 'package:one_dictionary/core/constants/strings.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

class MyTextStyle {
  static const wordTitle = TextStyle(
      fontSize: 30,
      color: Strings.appDarkBlue,
      fontWeight: FontWeight.bold);
  static const notationTitle = TextStyle(
    fontSize: 20,
    color: Strings.appMidGrey
  );
  static const bodyText1 = TextStyle(
    fontSize: 18,
    color: Strings.appBlue
  );
   static const bodyText1Bold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Strings.appBlue
  );
  static const bodyText2 = TextStyle(
    fontSize: 16,
    color: Strings.appDarkBlue
  );
}
