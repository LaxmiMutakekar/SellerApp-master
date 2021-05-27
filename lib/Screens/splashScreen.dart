import 'package:Seller_App/Screens/homeScreen/Home.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/mainScreen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  void splashScreen() {
    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacementNamed(context, MainScreen.routeName);
    });
  }

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   splashScreen();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.2),
              ),
              width: 16,
              height: 16,
            ),
            SizedBox(width: 10),
            Text(
              "loading..",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
