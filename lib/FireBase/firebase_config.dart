import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/notificationModel.dart';
import 'package:Seller_App/providers/notification.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseConfig {
  void init(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final seller = Provider.of<SellerProvider>(context, listen: false);
    final msgs = Provider.of<Messages>(context, listen: false);
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) {
      var devicetoken = token;
      print(devicetoken);
      if (token != seller.seller.deviceId) {
        APIServices.updateSellerDevice(devicetoken);
      }
    });
    //firebase configurations for app status
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _setMessage(message, order, msgs);
      },
      onLaunch: (Map<String, dynamic> message) async {
        _setMessage(message, order, msgs);
      },
      onResume: (Map<String, dynamic> message) async {},
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  _setMessage(
      Map<String, dynamic> message, OrderProvider order, Messages msgs) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    int oid = int.parse(title);
    //only for driver assigned and new orders added refresh the UI
    if (body == 'ORDER_DELIVERY_ASSIGNED') {
      order.fetchOrders();
    }
    if (body == 'Received a new order') {
      Message msg = Message(title, body, mMessage);
      msgs.addMessages(msg);
      msgs.readMessage();
      order.fetchOrders();
    }
    //updating the visibility of update_button after this notification to false
    if (body == 'ORDER_NO_UPDATE_ETC') {
      APIServices.updateButton(oid)
          .then((value) => value ? order.updateButton(oid) : null);
    }
    if(body=='Order Cancelled')
      {
        Message msg = Message(title, body, mMessage);
        msgs.addMessages(msg);
        msgs.readMessage();
        order.cancelledStatusChange(true);
        order.fetchOrders();
      }
  }
}
