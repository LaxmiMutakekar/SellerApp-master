import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../mainScreen.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
double duration = 0;

Future<dynamic> updateETC(BuildContext context) async {
  int _currentHorizontalIntValue = 10;
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Container(
              height: getProportionateScreenHeight(150),
              width: getProportionateScreenWidth(500),
              child: Column(
                children: [
                  NumberPicker(
                    value: _currentHorizontalIntValue,
                    minValue: 10,
                    maxValue: 40,
                    step: 1,
                    axis: Axis.horizontal,
                    haptics: true,
                    infiniteLoop: true,
                    selectedTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    onChanged: (value) =>
                        setState(() => _currentHorizontalIntValue = value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => setState(() {
                          final newValue = _currentHorizontalIntValue - 1;
                          _currentHorizontalIntValue = newValue.clamp(10, 40);
                        }),
                      ),
                      Text('Minutes: $_currentHorizontalIntValue'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => setState(() {
                          final newValue = _currentHorizontalIntValue + 1;
                          _currentHorizontalIntValue = newValue.clamp(10, 40);
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Continue'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Added $_currentHorizontalIntValue minutes")));
                          Navigator.of(context).pop(_currentHorizontalIntValue);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}
