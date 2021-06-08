import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData(context) {
  return ThemeData(
      fontFamily: "Raleway",
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey[300],
      highlightColor: Colors.black,
      dividerColor: Colors.black12,
      buttonColor: Colors.black,
      textTheme: textTheme(),
      appBarTheme: appBarTheme(),
      textButtonTheme: textButtonThemeData(),
      elevatedButtonTheme: elevatedButtonThemeData(),
      scaffoldBackgroundColor: Colors.grey[300],
      floatingActionButtonTheme: floatingActionButtonThemeData(),
      accentColor: Color(0xff393E43),
      tabBarTheme: tabBarTheme());
}
TabBarTheme tabBarTheme() {
  return TabBarTheme(
    labelPadding: EdgeInsets.all(0),
    unselectedLabelStyle: GoogleFonts.raleway(
        textStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    )),
    labelStyle: GoogleFonts.raleway(
        textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    )),
  );
}

FloatingActionButtonThemeData floatingActionButtonThemeData() {
  return FloatingActionButtonThemeData(
    elevation: 0,
    foregroundColor: Colors.white,
  );
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        fixedSize: Size(100, 20),
        elevation: 0,
        primary: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  );
}

TextButtonThemeData textButtonThemeData() {
  return TextButtonThemeData(
      style: TextButton.styleFrom(
    primary: Colors.black87,
  ));//texButtonThemeData
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );//appBarThemeData
}

textTheme() {
  return TextTheme(
    headline1: TextStyle(fontSize: 28.0),
    headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700,),
    headline6: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    subtitle1: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
    subtitle2: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,),
    bodyText2: TextStyle(fontSize: 16.0,),
    caption: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,),
    overline: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,),
    button: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
    ),
  );
}
