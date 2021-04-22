import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static String get token => _pref?.getString("token");

  static set token(String token) => _pref?.setString('token', token);

  static logout() {
    token = "";
    _pref?.clear();
  }
}
