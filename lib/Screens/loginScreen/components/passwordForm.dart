import 'package:Seller_App/models/loginModel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildPassWordform extends StatefulWidget {
  BuildPassWordform({
    Key key,
    @required this.loginRequestModel,
    @required this.hidePassword,
  }) : super(key: key);

  final LoginRequestModel loginRequestModel;
  bool hidePassword;

  @override
  _BuildPassWordformState createState() => _BuildPassWordformState();
}

class _BuildPassWordformState extends State<BuildPassWordform> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Theme.of(context).accentColor),
      keyboardType: TextInputType.text,
      onSaved: (input) => widget.loginRequestModel.password = input,
      obscureText: widget.hidePassword,
      decoration: new InputDecoration(
        hintText: "Password",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).accentColor.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor)),
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).accentColor,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.hidePassword = !widget.hidePassword;
            });
          },
          color: Theme.of(context).accentColor.withOpacity(0.4),
          icon: Icon(
              widget.hidePassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
