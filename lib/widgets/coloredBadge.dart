import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:flutter/material.dart';

class ColoredBadge extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final bool dense;
  final bool lowerCase;

  const ColoredBadge(
      {Key key,
      @required this.text,
      this.color,
      this.backgroundColor,
      this.dense = false,
      this.lowerCase = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(30),
      child: Center(
        child: Text(
          lowerCase ? "$text" : "$text".toUpperCase(),
          textScaleFactor: dense ? 0.7 : 0.8,
        
          style: TextStyle(
            color: color ?? Theme.of(context).accentColor,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor ??
            color?.withOpacity(0.2) ??
            Theme.of(context).accentColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: dense ? 3 : 8, vertical: dense ? 0 : 2),
    );
  }
}
