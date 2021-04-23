import 'package:flutter/material.dart';
import 'package:order_listing/APIServices/APIServices.dart';
import 'package:order_listing/models/orders.dart';

class Update extends ChangeNotifier {
  List<Orders> ordersList = [];
  String sellerName = " ";
  bool sellerAvlb = true;
  void ordersAdded() async {
    ordersList = await APIServices.fetchOrders();
    notifyListeners();
  }

  void updateOrderStatus(String status, int index) {
    ordersList[index].status = status;
    notifyListeners();
  }

  void fetchName() async {
    sellerName = await APIServices.fetchSeller().then((value) => value.name);
    notifyListeners();
  }

  void fetchAvlb() async {
    sellerAvlb =
        await APIServices.fetchSeller().then((value) => value.available);
    notifyListeners();
  }

  void updateStatus(bool value) {
    sellerAvlb = value;
    notifyListeners();
  }
}
