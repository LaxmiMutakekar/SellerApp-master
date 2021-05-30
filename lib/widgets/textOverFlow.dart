import 'package:flutter/material.dart';
class OverFlowText extends StatelessWidget {
  const OverFlowText({
    Key key,
    @required this.text,
    this.textSize,
    this.width,
  }) : super(key: key);

  final String text;
  final double textSize;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??200,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:TextStyle(fontSize: textSize??16,fontWeight: FontWeight.w500,color: Colors.grey[600]),
      ),
    );
  }
}