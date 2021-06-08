import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/HomeScreen/Home.dart';
import 'package:Seller_App/loadindScreen.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/Screens/loginScreen/loginScreen.dart';
import 'package:Seller_App/session.dart';

class RootPage extends StatelessWidget {
  static String routeName = "/root";

  Future<String> readStorage() async {
    return Session.token ?? "";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
        future: readStorage(),
        builder: (ctx, snapshot) {

          if (snapshot.hasData) {
            //if device local data is empty means either he is logging in for first time
            // or he logged out last time hence direct him to LoginScreen
            if (snapshot.data == "") {
              return LoginPage();
            }
            //device local has the token hence keep in logged in and check the server status
            else
              return LoadingScreen();
          } else {
            return Container();
          }
        });
  }
}
