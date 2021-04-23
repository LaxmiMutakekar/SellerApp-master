import 'package:order_listing/Home.dart';
import 'package:flutter/material.dart';
import 'package:order_listing/screens/LoginScreen.dart';
import 'package:order_listing/session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  
  Future<String> readStorage() async {
    print(Session.token);
    return Session.token ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: readStorage(),
          builder: (ctx, snapshot) {
            print(snapshot.data);
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