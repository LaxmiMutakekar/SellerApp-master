import 'package:flutter/material.dart';
import 'package:Seller_App/models/notificationModel.dart';
class Messages with ChangeNotifier{
  List<Message> messagesList=[];
  bool isRead=true;
  int unreadCount=0;
  void addMessages(Message msg)
  {
    unreadCount++;
    messagesList.add(msg);
    notifyListeners();
  }
  void readMessage()
  {
    isRead=false;
    notifyListeners();
  }
  void messageRead()
  {
    unreadCount=0;
    isRead=true;
    notifyListeners();
  }
  void clearAllmessages()
  {
    messagesList.clear();
    notifyListeners();
  }
}