import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 double kButtonRadius=5;
class AppConfig {
  static Color loadingColorforworg=Colors.black38;
  static Color homeScreen=Color(0xffCCCCCD);
  static Color backgroundM=Color(0xffE5E5E5);
  static Color drawerBackground=Color(0xff393E43);
  static Color hidingText=Colors.grey[500];
  static Color buttonSplash=Color(0xffACDF87);
  static Color buttonText=Colors.white;
  static Color buttonBackgrd=Colors.black;
  static Color iconColor=Colors.black45;
  static double errorBoxHeight=170;
  static double errorBoxwidth=300;
  static double headindFont=20;
  static double headingPading=10;
  static const String pendingStatus='Order Placed';
  static const String preparingStatus='Order Preparing';
  static const String readyStatus='Order Ready';
  static const String rejectedStatus='Order Rejected';
  static const String delayedStatus='Order Timeout';
  static const String handedoverStatus='Delivery Assigned';
  static const String doneStatus='Order Complete';
  static double elevation=8;
  static Color readyColor=Color(0xff10942C);
  static Color preparingColor=Color(0xff0089A9);
  static Color delayedColor=Color(0xffC82020);
  static Color completedColor=Colors.green[300];
  static String baseUrl='http://10.0.2.2:8080';
  static String currenlyNoOrder='Currently you don\'t have any orders!!';
  static String noPendingOrders='No new orders are received';
  static String availableError='You can\'t receive orders as you are offline, if you have any active orders please fulfill them';
  static var format =  DateFormat('dd-MM-yyyy');
  static var getColor=
  {
    preparingStatus:preparingColor,
    readyStatus:readyColor,
    delayedStatus:delayedColor
  };
  static Future goto(BuildContext context, Widget page, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => page),
      );
    }
    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (_) => page),
    );
  }
}

