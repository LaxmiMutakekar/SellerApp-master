import 'package:flutter/material.dart';

Future<dynamic> showAleartDialog(
    BuildContext context, String title, Widget content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    //this means the user must tap a button to exit the Alert Dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: <Widget>[
          FlatButton(
            child: Text('continue'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
