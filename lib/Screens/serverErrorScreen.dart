import 'package:flutter/material.dart';

class ServerError extends StatelessWidget {
  const ServerError({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Opacity(
                opacity: 0.6,
                child: Text(
                  '500',
                  style: TextStyle(fontSize: 80),
                )),
            Text(
              'ERROR',
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text('Internal server error.'),
      ],
    ))));
  }
}
