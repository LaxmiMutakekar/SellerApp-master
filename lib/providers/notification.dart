import 'package:flutter/material.dart';
class NotificationCount extends ChangeNotifier{
  int count=0;
  void updateCount(){
    count++;
    notifyListeners();
  }

}