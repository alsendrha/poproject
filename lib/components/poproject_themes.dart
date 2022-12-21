import 'package:flutter/material.dart';
import 'package:poproject/components/poproject_color.dart';

class PoprojectThems {
  static ThemeData get lightTheme => ThemeData(
    primarySwatch: PoprojectColors.primaryMeterialColor,
    fontFamily: 'KOTRAHOPETTF',
    scaffoldBackgroundColor: Colors.white, // scaffold 는 appbar외의 배경
    splashColor: Colors.white, // 클릭했을때 컬러
    textTheme: _textTheme,
    appBarTheme: _appBarTheme,
    brightness: Brightness.light,
  );
  static ThemeData get darkTheme => ThemeData(
    primarySwatch: PoprojectColors.primaryMeterialColor,
    fontFamily: 'KOTRAHOPETTF',
    // scaffoldBackgroundColor: Colors.white, // scaffold 는 appbar외의 배경
    splashColor: Colors.white, // 클릭했을때 컬러
    textTheme: _textTheme,
    brightness: Brightness.dark,
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: PoprojectColors.primaryColor,
    ),
    elevation: 0,
  );
  static const TextTheme _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      // color: PoprojectColors.primaryColor,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      // color: PoprojectColors.primaryColor,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      // color: PoprojectColors.primaryColor,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
      // color: PoprojectColors.primaryColor,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      // color: PoprojectColors.primaryColor,
    ),
    button: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      // color: PoprojectColors.primaryColor,
    ),
  );
}