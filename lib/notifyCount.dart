import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Count {
  static SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
    print(getIntFromSharedPref());
  }
  static int getIntFromSharedPref()  {
    final count = _pref.getInt('count');
    if (count == null) {
      return 0;
    }
    return count;
  }
    static void resetCounter()  {
     _pref.setInt('count', 0);
     _pref?.clear();
  }
  static void  incrementStartup()  {
    int lastStartupNumber = getIntFromSharedPref();
    int currentStartupNumber = ++lastStartupNumber;
     _pref.setInt('count', currentStartupNumber);
  }
}
