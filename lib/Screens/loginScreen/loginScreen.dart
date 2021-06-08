import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/models/loginModel.dart';
import 'package:Seller_App/Screens/loginScreen/components/progressHUD.dart';
import 'components/loginBody.dart';

class LoginPage extends StatefulWidget {
  static String routeName="/login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: LoginBody(
        hidePassword: hidePassword,
        scaffoldKey: scaffoldKey,
        isApiCallProcess: isApiCallProcess,
      ),
    );
  }
}
