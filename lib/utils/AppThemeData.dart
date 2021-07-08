import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Theme Data for the Application

ThemeData appLightTheme() {
  return ThemeData(
      primarySwatch: Colors.teal,
      primaryColor: Colors.teal[700],
      highlightColor: Colors.yellow[800],
      buttonColor: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[200],
      tabBarTheme: TabBarTheme(
        labelColor: Colors.yellow[800],
        unselectedLabelColor: Colors.white38,
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        indicatorSize: TabBarIndicatorSize.label,
      ),
      backgroundColor: Colors.white,
      cardColor: Colors.black,
      dividerColor: Colors.black,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      textTheme: GoogleFonts.artifikaTextTheme(
        TextTheme(
          headline1: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
          headline2: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
          headline3: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          headline4: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          headline5: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          headline6: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          bodyText1: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          bodyText2: TextStyle(
              color: Colors.grey[600],
              fontSize: 10,
              fontWeight: FontWeight.w400),
          subtitle1: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      iconTheme: IconThemeData(color: Colors.black, size: 25));
}

ThemeData appDarkTheme() {
  return ThemeData(
      primarySwatch: Colors.teal,
      primaryColor: Colors.teal[700],
      highlightColor: Colors.yellow[800],
      buttonColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      tabBarTheme: TabBarTheme(
        labelColor: Colors.yellow[800],
        unselectedLabelColor: Colors.white38,
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        indicatorSize: TabBarIndicatorSize.label,
      ),
      backgroundColor: Colors.black,
      cardColor: Colors.white,
      dividerColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: GoogleFonts.artifikaTextTheme(
        TextTheme(
          headline1: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          headline2: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
          headline3: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          headline4: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          headline5: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          headline6: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          bodyText1: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
          bodyText2: TextStyle(
              color: Colors.grey[600],
              fontSize: 10,
              fontWeight: FontWeight.w400),
          subtitle1: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 25));
}
