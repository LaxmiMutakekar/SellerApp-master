import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key key,
    @required this.text,
    this.textColor,
    this.buttonColor,
    this.shape,
    @required this.press,
  }) : super(key: key);
  String text;
  var press;
  final Color textColor;
  final Color buttonColor;
  final shape;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: shape ??
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kButtonRadius)),
        color: buttonColor ?? Colors.black,
        onPressed: press,
        elevation: 0,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: textColor ?? Colors.white),
        ));
  }
}
