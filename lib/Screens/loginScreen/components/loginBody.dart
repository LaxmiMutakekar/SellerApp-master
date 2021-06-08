import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/Screens/HomeScreen/Home.dart';
import 'package:Seller_App/Screens/loginScreen/components/emailForm.dart';
import 'package:Seller_App/Screens/loginScreen/components/passwordForm.dart';
import 'package:Seller_App/models/loginModel.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
   LoginBody({
    Key key,
    @required this.hidePassword,
    @required this.scaffoldKey,
    @required this.isApiCallProcess,
  }) : super(key: key);

  final bool hidePassword;
  final GlobalKey<ScaffoldState> scaffoldKey;
  bool isApiCallProcess;
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 200, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 20)
                  ],
                ),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 20),
                      BuildEmailFormField(loginRequestModel: loginRequestModel),
                      SizedBox(height: 20),
                       BuildPassWordform(loginRequestModel: loginRequestModel, hidePassword: widget.hidePassword),
                      SizedBox(height: 30),
                      FlatButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 80),
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              widget.isApiCallProcess = true;
                            });
                            APIServices.login(loginRequestModel)
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  widget.isApiCallProcess = false;
                                });
                                if (value.runtimeType != LoginResponseModel) {
                                  final snackBar = SnackBar(
                                      content: Text("Sorry server error!"));
                                  widget.scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                }
                                else {
                                  if (value.token.isNotEmpty) {
                                    final snackBar = SnackBar(
                                        content: Text("Login Successful"));
                                    widget.scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                    Navigator.pushNamed(
                                        context,
                                        HomeScreen.routeName);
                                  } else {
                                    final snackBar =
                                    SnackBar(content: Text(value.error));
                                    widget.scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  }
                                }
                              }
                            });
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}