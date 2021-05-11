import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key key,
    @required this.text,
    @required this.press,
  }) : super(key: key);
  String text;
  var press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: press,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ));
  }
}