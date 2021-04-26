import 'package:Seller_App/Home.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/screens/LoginScreen.dart';
import 'package:Seller_App/session.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Future<String> readStorage() async {
    return Session.token ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: readStorage(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == "") {
                return LoginPage();
              } else
                return HomeScreen();
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 10,
              ));
            }
          }),
    );
  }
}
