import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/providers/orderUpdate.dart';

String productName(List<OrderItem> data) {
  String productNames = "";
  String firstHalf = "";
  for (int i = 0; i < data.length; i++) {
    if (i == data.length - 1) {
      productNames += data[i].productName + " ";
    } else {
      {
        productNames += data[i].productName + ", ";
      }
    }
  }
  if (productNames.length > 15) {
    for (int i = 0; i < 15; i++) {
      firstHalf += productNames[i];
    }
    productNames = firstHalf + "...";
  }
  return productNames;
}

void showInSnackBar(String value, BuildContext context) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    content: new Text(value,style: TextStyle(fontWeight: FontWeight.bold),),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.green[300],
  ));
}

class SwitchButton extends StatefulWidget {
  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<Update>(builder: (context, Update orders, child) {
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
          value: orders.sellerAvlb,
          borderRadius: 15.0,
          padding: 0.0,
          showOnOff: true,
          onToggle: (val) {
            setState(() {
              showAleart(val);
            });
          });
    });
  }

  showAleart(val) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: val ? Text("Go online") : Text('Go Offline'),
      onPressed: () {
        setState(() {
          Provider.of<Update>(context, listen: false).updateStatus(val);
        });
        APIServices.updateAvailable(val);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Warning!"),
      content: val
          ? Text("Are you sure you want to go online")
          : Text("Are you sure you want to go Offline"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

Container errorBox() {
  return Container(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: Container(
            height: AppConfig.errorBoxHeight,
            width: AppConfig.errorBoxwidth,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.block_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        'You cant receive orders as you are offline, if you have any pending orders please fulfill them ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300)),
                  )
                ]),
          ),
        ),
      ),
    ),
  );
}
