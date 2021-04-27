import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/products.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/providers/products.dart';

class SwitchButton {
  showSwitch(context, index) {
    return Consumer<Product>(builder: (context, Product products, child) {
      Products item = products.productsList[index];
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
          value: item.available,
          borderRadius: 15.0,
          padding: 0.0,
          showOnOff: true,
          onToggle: (val) {
            showAleart(item,index, val, context);
          });
    });
  }

  showAleart(item,index, val, context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: val ? Text("Go online") : Text('Go Offline'),
      onPressed: () {
        
        Provider.of<Product>(context, listen: false).updateAvlb(index, val);

        APIServices.updateProduct(item.pid, val);
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
