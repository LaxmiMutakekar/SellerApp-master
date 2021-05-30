import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/App_configs/app_configs.dart';

class OrderProvider extends ChangeNotifier {
  dynamic ordersList = [];
  List<Orders> pendingOrderList = [];
  List<Orders> activeOrderList = [];
  List<Orders> rejectedOrderList = [];
  List<Orders> completedOrderList = [];
  List<Orders> preparingOrderList = [];
  List<Orders> readyOrderList = [];
  List<Orders> delayedOrderList = [];
  void ordersAdded()async {
    //all order lists cleared
    pendingOrderList.clear();
    activeOrderList.clear();
    rejectedOrderList.clear();
    completedOrderList.clear();
    preparingOrderList.clear();
    readyOrderList.clear();
    delayedOrderList.clear();
    ordersList = await APIServices.fetchOrders();
    ordersList.forEach((element) {
      switch (element.status) {
        //pending orders added
        case AppConfig.pendingStatus:
          pendingOrderList.add(element);
          break;
        // active orders according to status added to respective list
        case AppConfig.preparingStatus:
          {
            preparingOrderList.add(element);
            activeOrderList.add(element);
          }
          break;
        case AppConfig.raedyStatus:
          {
            readyOrderList.add(element);
            activeOrderList.add(element);
          }
          break;
        case AppConfig.delayedStatus:
          {
            delayedOrderList.add(element);
            activeOrderList.add(element);
          }
          break;
        //rejected orders added
        case AppConfig.rejectedStatus:
          {
            rejectedOrderList.add(element);
          }
          break;
        //completed orderds added
        default:
          completedOrderList.add(element);
          break;
      }
    });
    notifyListeners();
  }

  void acceptOrder(Orders order) {
    order.status = AppConfig.preparingStatus;
    activeOrderList.add(order);
    preparingOrderList.add(order);
    pendingOrderList.remove(order);
    notifyListeners();
  }
  void rejectOrder(Orders order) {
    order.status = AppConfig.rejectedStatus;
    rejectedOrderList.add(order);
    pendingOrderList.remove(order);
    notifyListeners();
  }

  void activeOrdersUpdate(Orders order, String status) {
    order.status = status;
    preparingOrderList.remove(order);
    switch (status) {
      case AppConfig.raedyStatus:
        {
          //moved to ready orders
          readyOrderList.add(order);    
        }
        break;
      case AppConfig.delayedStatus:
        {
          //moved to delayed orders
          delayedOrderList.add(order);
        }
        break;
    }
    notifyListeners();
  }
  void completeOrders(Orders order) {
    switch (order.status) {
      case AppConfig.preparingStatus:
        {
          //preparing order removed
          preparingOrderList.remove(order);
        }
        break;
      case AppConfig.raedyStatus:
        {
          //ready order moved to completed
          readyOrderList.remove(order);
        }
        break;
      case AppConfig.delayedStatus:
        {
          //delayed order moved to completed
          delayedOrderList.remove(order);
        }
        break;
    }
    order.status = AppConfig.doneStatus;
    completedOrderList.add(order);
    activeOrderList.remove(order);
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

  void updateButton(int oid) {
    activeOrderList
        .firstWhere((element) => element.orderId == oid)
        .isOrderUpdateEtc = false;
    notifyListeners();
  }
  void orderUpdate(String status, Orders order) {
    switch (status) {
      case AppConfig.preparingStatus:
        {
          //preparing removed
          preparingOrderList.remove(order);
        }
        break;
      case AppConfig.raedyStatus:
        {
          //ready orders
          readyOrderList.add(order);
          preparingOrderList.remove(order);
        }
        break;
      case AppConfig.delayedStatus:
        {
          //delayed orders
          delayedOrderList.add(order);
          preparingOrderList.remove(order);
        }
        break;
    }
  }
}
