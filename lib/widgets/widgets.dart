import 'package:Seller_App/widgets/cards.dart';
import 'package:flutter/material.dart';
void showInSnackBar(String value, BuildContext context) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    content: new Text(
      value,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.green[300],
  ));
}
class DefaultIconButton extends StatelessWidget {
   DefaultIconButton({
    Key key,
    @required this.icon,
    @required this.onPress,
  }) : super(key: key);

  final Icon icon;
   var onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: icon,
        onPressed: onPress,
        );
  }
}
class TextContainer extends StatelessWidget {
   TextContainer({
    Key key,
    @required this.text,
    this.textSize,
  }) : super(key: key);
   String text;
    double textSize;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 40),
      child: Cards(
          child: Text(text,textAlign: TextAlign.center,style: TextStyle( fontSize: textSize??16,fontWeight: FontWeight.w100),)
          )),
    );
  }
}
