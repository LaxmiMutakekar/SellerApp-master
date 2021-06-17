import 'package:Seller_App/models/loginModel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PassWordFieldValidator{
  static validator(String value)
  {
    return value.isEmpty ? "Password can't be left empty" : null;
  }
}
class BuildPassWordform extends StatefulWidget {
   BuildPassWordform({
    Key key,
    @required this.loginRequestModel,
  }) : super(key: key);

  final LoginRequestModel loginRequestModel;

  @override
  _BuildPassWordformState createState() => _BuildPassWordformState();
}

class _BuildPassWordformState extends State<BuildPassWordform> {
  bool hidePassword;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hidePassword=true;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Theme.of(context).accentColor),
      keyboardType: TextInputType.text,
      validator: (value)=>PassWordFieldValidator.validator(value),
      onSaved: (input) => widget.loginRequestModel.password = input,
      obscureText: hidePassword,
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
              print('Icon pressed');
              hidePassword = !hidePassword;
            });
          },
          color: Theme.of(context).accentColor.withOpacity(0.4),
          icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
