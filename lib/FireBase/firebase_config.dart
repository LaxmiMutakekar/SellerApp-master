import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/notifyCount.dart';
class FirebaseConfig{
  void init(BuildContext context){
    final order=Provider.of<Update>(context, listen: false);
    final seller=Provider.of<SellerDetail>(context, listen: false);
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) {
      var devicetoken = token;
      if(token!=seller.seller.deviceId)
      {
          APIServices.updateSellerDevice(devicetoken);
      }
      print("Device Token: $token");
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message,order); 
      },
      onLaunch: (Map<String, dynamic> message) async {
      },
      onResume: (Map<String, dynamic> message) async {
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }
  _setMessage(Map<String, dynamic> message,Update order) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    int oid=int.parse(title);
    if(body=='ORDER_ADDED'||body=='ORDER_DELIVERY_ASSIGNED')
    {
      order.ordersAdded();
      body=='ORDER_DELIVERY_ASSIGNED'?Count.incrementStartup():null;
      print('in body');
    }
    if(body=='ORDER_NO_UPDATE_ETC')
    {
      APIServices.updateButton(oid).then((value) =>value?order.updateButton(oid):null);
    }
    print("Title: $title, body: $body, message: $mMessage");
  
}
}

