import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FirebaseConfig{
  void init(BuildContext context){

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) {
      var devicetoken = token;
      APIServices.updateSellerDevice(devicetoken);
      print("Device Token: $token");
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Provider.of<Update>(context, listen: false).ordersAdded();
      },
      onLaunch: (Map<String, dynamic> message) async {
        //print('onLaunch: $message');
        // _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        Provider.of<Update>(context, listen: false).ordersAdded();

      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }
}

