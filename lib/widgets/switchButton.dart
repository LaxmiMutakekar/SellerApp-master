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
    this.pid,
    this.index,
    
  }) : super(key: key);
  bool value;
  String type;
  int pid;
  int index;
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
        value: widget.value??true,
        borderRadius: 15.0,
        padding: 0.0,
        showOnOff: true,
        onToggle: (val) {
          setState(() {
            (widget.type=='Seller')?showAleart(val):productAleart(val,widget.index,widget.pid);
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
          Provider.of<SellerDetail>(context, listen: false).changeAvailabiliy(val);
        });
        APIServices.updateAvailable(val);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Warning!"),
      content: val
          ? Text("Are you sure you want to go online",textAlign: TextAlign.center,)
          : Text("Are you sure you want to go Offline",textAlign: TextAlign.center),
      actions: [
        cancelButton,
        continueButton
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  productAleart(val,index,pid) {
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

        APIServices.updateProduct(pid, val);
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
        continueButton
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
