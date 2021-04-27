import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/orders.dart';

class Update extends ChangeNotifier {
  List<Orders> ordersList = [];

  String sellerName = " ";
  String chosenValue = 'All accepted orders';
  bool sellerAvlb = true;
  void ordersAdded() async {
    ordersList = await APIServices.fetchOrders();
    notifyListeners();
  }
  void sort(String value) {
    chosenValue=value;
    notifyListeners();
  }
  void updateOrderStatus(String status, int index) {
    ordersList[index].status = status;
    //print(status);
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
