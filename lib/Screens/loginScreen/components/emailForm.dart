import 'package:Seller_App/models/loginModel.dart';
import 'package:flutter/material.dart';
class EmailFieldValidator{
 static validate(String value)
  {
    return !value.contains('@') ? "Email Id should be valid" : null;
  }
}
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
      validator: (input) =>
          EmailFieldValidator.validate(input),
      decoration: new InputDecoration(
        hintText: "Email Address",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).accentColor.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor)),
        prefixIcon: Icon(
          Icons.email,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
