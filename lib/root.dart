import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/HomeScreen/Home.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/Screens/loginScreen/loginScreen.dart';
import 'package:Seller_App/session.dart';
class RootPage extends StatelessWidget {
static String routeName="/root";
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
        });
  }
}
