import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/Screens/HomeScreen/Home.dart';
import 'package:Seller_App/Screens/loginScreen/components/emailForm.dart';
import 'package:Seller_App/Screens/loginScreen/components/passwordForm.dart';
import 'package:Seller_App/models/loginModel.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  LoginBody({
    Key key,
    @required this.isApiCallProcess,
  }) : super(key: key);

  bool isApiCallProcess;
  var client;

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  bool hidePassword;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
    hidePassword = true;
    //print(loginRequestModel.password);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: SingleChildScrollView(
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
                          TextFormField(
                            key: Key('email'),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => loginRequestModel.email = input,
                            validator: (input) =>
                                EmailFieldValidator.validate(input),
                            decoration: new InputDecoration(
                              hintText: "Email Address",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            key: Key('Password'),
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                PassWordFieldValidator.validator(value),
                            onSaved: (input) =>
                                loginRequestModel.password = input,
                            obscureText: hidePassword,
                            decoration: new InputDecoration(
                              hintText: "Password",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).accentColor,
                              ),
                              suffixIcon: IconButton(
                                key: Key('hidePassword'),
                                onPressed: () {
                                  setState(() {
                                    print('Icon pressed');
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          FlatButton(
                            key: Key('LoginButton'),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            onPressed: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                currentFocus.focusedChild.unfocus();
                              }
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

                                    if (value.token.isNotEmpty) {
                                      final snackBar = SnackBar(
                                          content: Text("Login Successful"));
                                      scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomeScreen()),
                                      );
                                    } else {
                                      final snackBar =
                                          SnackBar(content: Text(value.error));
                                      scaffoldKey.currentState
                                          .showSnackBar(snackBar);
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
        ),
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
