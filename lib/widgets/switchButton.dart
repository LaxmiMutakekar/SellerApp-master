import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/providers/products.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class DefaultSwitch extends StatefulWidget {
  DefaultSwitch({
    Key key,
    @required this.value,
    @required this.type,
    this.model,
    this.product,
  }) : super(key: key);
  bool value;
  String type;
  var product;
  var model;
  @override
  _DefaultSwitchState createState() => _DefaultSwitchState();
}

class _DefaultSwitchState extends State<DefaultSwitch> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        activeSwitchBorder: Border.all(width: 2, color: Colors.green),
        activeColor: Colors.white,
        activeToggleColor: Colors.green,
        inactiveToggleBorder: Border.all(width: 3.0, color: Colors.black),
        activeToggleBorder: Border.all(width: 2.0, color: Colors.green),
        width: 45.0,
        height: 20.0,
        valueFontSize: 10.0,
        activeTextColor: Colors.green,
        toggleSize: 18.0,
        value: widget.value ?? true,
        borderRadius: 15.0,
        padding: 0.0,
        showOnOff: false,
        onToggle: (val) {
          setState(() {
            showMyDialog(context, val).then((value) {
              print(value);
              if (value == true) {
                if (widget.type == 'Seller') {
                  widget.model.changeAvailabiliy(val);
                  APIServices.updateAvailable(val);
                } else {
                  widget.model.updateAvlb(widget.product, val);
                  APIServices.updateProduct(widget.product.pid, val);
                }
              }
            });
          });
        });
  }
}

Future<bool> showMyDialog(BuildContext context, bool val) async {
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: val ? Text("Go online") : Text('Go Offline'),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop(true);
    },
  );
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Warrning!'),
        content: val
            ? Text("Are you sure you want to go online")
            : Text("Are you sure you want to go Offline"),
        actions: <Widget>[cancelButton, continueButton],
      );
    },
  );
}
