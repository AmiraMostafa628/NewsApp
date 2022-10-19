import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'color.dart';

ThemeData darkTheme =ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor:HexColor('333739'),
  appBarTheme: AppBarTheme(
      backgroundColor: HexColor('333739'),
      iconTheme: IconThemeData(
          color: Colors.white ),
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light
      ),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.white
      )
  ),

);

ThemeData lightTheme =ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white ,
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
          color: Colors.black ),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
      )

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey[400],
    backgroundColor: Colors.white
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black
      )
  ),
);