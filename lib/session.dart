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
class GetToken{
  static String tokenVal='';
  static String get tokenValue=>Session.token??tokenVal;
  static set tokenValue(String token)=>tokenVal=token;

}
