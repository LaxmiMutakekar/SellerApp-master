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
        case AppConfig.readyStatus:
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
    //after accepting order order is moved to preparingList from pending list 
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
    
    switch (status) {
      case AppConfig.readyStatus:
        {
          //moved to ready orders
          order.isOrderUpdateEtc=false;
          readyOrderList.add(order);   
          if(order.status==AppConfig.delayedStatus)
          {
            delayedOrderList.remove(order);
          }
          else{
            preparingOrderList.remove(order);
          }
        }
        break;
      case AppConfig.delayedStatus:
        {
          //moved to delayed orders
          delayedOrderList.add(order);
          preparingOrderList.remove(order);
        }
        break;
    }
    order.status = status;
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
      case AppConfig.readyStatus:
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
    //updating the visibility of button to false
    order.isOrderUpdateEtc=false;
    order.orderPreparationTime = order.orderPreparationTime + value;
    notifyListeners();
  }

  void updateAcceptTimings(Orders order, DateTime value) {
    APIServices.changeOrderStatus(order, AppConfig.preparingStatus);
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
      case AppConfig.readyStatus:
        {
          //ready orders
          readyOrderList.add(order);
          if(order.status==AppConfig.delayedStatus)
          {
            delayedOrderList.remove(order);
          }
          else
          {
              preparingOrderList.remove(order);
          }
          
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