import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
class Update extends ChangeNotifier {
  List<Orders> ordersList = [];
  List<Orders> pendingOrders=[];
  List<Orders> activeOrders=[];
  List<Orders>rejectedOrders=[];
  List<Orders>completedOrders=[];
  DateTime time=DateTime.now();
  String chosenValue = 'All accepted orders';
  void ordersAdded() async {
    pendingOrders.clear();
    activeOrders.clear();
    rejectedOrders.clear();
    completedOrders.clear();
    ordersList = await APIServices.fetchOrders();
    //print('orderList'+ordersList.length.toString());
    ordersList.forEach((element) {if(element.status==AppConfig.pendingStatus){
      pendingOrders.add(element);
    }});
    //print('pending   '+pendingOrders.length.toString());
    ordersList.forEach((element) {if(element.status==AppConfig.acceptStatus||element.status==AppConfig.markAsDone||element.status==AppConfig.timeout){
      activeOrders.add(element);
    }});
    //print('active  '+activeOrders.length.toString());
    ordersList.forEach((element) {if(element.status==AppConfig.rejectedStatus){
      rejectedOrders.add(element);
    }});
    //print('rejected'+rejectedOrders.length.toString());
    ordersList.forEach((element) {if(element.status==AppConfig.doneStatus){
      completedOrders.add(element);
    }});
    //print('completed'+completedOrders.length.toString());
    notifyListeners();
  }
  void sort(String value) {
    chosenValue=value;
    notifyListeners();
  }
  void acceptOrder(int index) {
    pendingOrders[index].status=AppConfig.acceptStatus;
    activeOrders.add(pendingOrders[index]);
    //print('active'+activeOrders.length.toString());
    //print('index'+index.toString());
    pendingOrders.removeAt(index);
    //print('pending'+pendingOrders.length.toString());
    notifyListeners();
  }
  void rejectOrder(int index){
    pendingOrders[index].status=AppConfig.rejectedStatus;
    rejectedOrders.add(pendingOrders[index]);
    //print('rejected'+activeOrders.length.toString());
    //print('index'+index.toString());
    pendingOrders.removeAt(index);
    //print('pending'+pendingOrders.length.toString());
    notifyListeners();
  }
  void activeOrdersUpdate(int index,String status)
  {
    activeOrders[index].status=status;
    notifyListeners();
  }
  void completeOrders(int index){
   // print('removed oid '+activeOrders[index].orderId.toString());
    activeOrders[index].status=AppConfig.doneStatus;
    completedOrders.add(activeOrders[index]);
    activeOrders.removeAt(index);
    notifyListeners();
  }
}
