import 'package:flutter/material.dart';
import 'package:order_listing/models/rejectionReasons.dart';
class RejectionReasons extends ChangeNotifier {
  String _currentReason = reasons[0];
  RejectionReasons();

  String get currentReason => _currentReason;

  updateReason(String value) {
    if (value != _currentReason) {
      _currentReason = value;
      print(_currentReason);
      notifyListeners();
    }
  }
}