import 'package:Seller_App/Screens/homeScreen/Home.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/mainScreen.dart';
import 'package:Seller_App/internetCheck.dart';
import 'package:Seller_App/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
class Splash extends StatefulWidget {
  static String routeName="/splashScreen";
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  void splashScreen() {
    //after delay of 1500ms navigates to connectivity check till then shows image
    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, IsConnected.routName);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      splashScreen();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/Images/photo.png',height: 200,),
        ),
      ),
    );
  }
}
