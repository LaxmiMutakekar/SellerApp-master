import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/App_configs/app_configs.dart';

class Update extends ChangeNotifier {
  List<Orders> ordersList = [];
  List<Orders> pendingOrders = [];
  List<Orders> activeOrders = [];
  List<Orders> rejectedOrders = [];
  List<Orders> completedOrders = [];
  DateTime time = DateTime.now();
  String chosenValue = 'All accepted orders';

  void ordersAdded() async {
    pendingOrders.clear();
    activeOrders.clear();
    rejectedOrders.clear();
    completedOrders.clear();
    ordersList = await APIServices.fetchOrders();
    ordersList.forEach((element) {
      if (element.status == AppConfig.pendingStatus) {
        pendingOrders.add(element);
      } else if (element.status == AppConfig.acceptStatus ||
          element.status == AppConfig.markAsDone ||
          element.status == AppConfig.timeout) {
        activeOrders.add(element);
      } else if (element.status == AppConfig.rejectedStatus &&
          (element.orderPlacedDate.day == DateTime.now().day)) {
        rejectedOrders.add(element);
      } else if (element.status == AppConfig.doneStatus) {
        completedOrders.add(element);
      }
    });
    notifyListeners();
  }

  void sort(String value) {
    chosenValue = value;
    notifyListeners();
  }

  void acceptOrder(int index) {
    pendingOrders[index].status = AppConfig.acceptStatus;
    activeOrders.add(pendingOrders[index]);
    pendingOrders.removeAt(index);
    notifyListeners();
  }

  void rejectOrder(int index) {
    pendingOrders[index].status = AppConfig.rejectedStatus;
    rejectedOrders.add(pendingOrders[index]);
    pendingOrders.removeAt(index);
    notifyListeners();
  }

  void activeOrdersUpdate(Orders order, String status) {
    order.status = status;
    notifyListeners();
  }

  void completeOrders(Orders order) {
    order.status = AppConfig.doneStatus;
    completedOrders.add(order);
    activeOrders.remove(order);
    notifyListeners();
  }

  void updateETC(Orders order, double value) {
    order.orderPreparationTime = order.orderPreparationTime + value;

    notifyListeners();
  }

  void updateAcceptTimings(Orders order, DateTime value) {
    order.orderStatusHistory.orderPreparing = value;
    notifyListeners();
  }
  void updateButton(int oid)
  {
    activeOrders.firstWhere((element) => element.orderId==oid).isOrderUpdateEtc=false;
    notifyListeners();
  }
}
