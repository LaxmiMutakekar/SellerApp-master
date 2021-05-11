import 'package:Seller_App/models/loginModel.dart';
import 'package:flutter/material.dart';
class BuildEmailFormField extends StatelessWidget {
  const BuildEmailFormField({
    Key key,
    @required this.loginRequestModel,
  }) : super(key: key);

  final LoginRequestModel loginRequestModel;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => loginRequestModel.email = input,
      validator: (input) => !input.contains('@')
          ? "Email Id should be valid"
          : null,
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
    );
  }
}
