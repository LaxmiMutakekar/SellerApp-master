import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

  ThemeData themeData(context){
    return ThemeData(
        fontFamily:"Raleway",
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[300],
        highlightColor: Colors.black,
        dividerColor: Colors.black12,
        buttonColor: Colors.black,
        textTheme: textTheme(),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.black87,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(100, 20),
              elevation: 5,
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
        ),
        scaffoldBackgroundColor: Colors.grey[300],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        accentColor: Color(0xff393E43),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.all(0),

          unselectedLabelStyle:GoogleFonts.raleway(textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ) ),
          labelStyle: GoogleFonts.raleway(textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ) ),
        )
    );
  }
  textTheme(){
    return TextTheme(
      headline1:
      TextStyle(fontSize: 28.0),
      headline2:  TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
      ),
      headline6: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      subtitle1:  TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      subtitle2:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText2:  TextStyle(
        fontSize: 14.0,
      ),
      caption:  TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      overline: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      button:TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
