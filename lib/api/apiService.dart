import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/tokenModel.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../model/loginModel.dart';
import '../model/orders.dart';
import 'package:Seller_App/model/Seller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIService {

  build(BuildContext context) {}
  APIService({context});
  
  static final storage = new FlutterSecureStorage();
  static Future<LoginResponseModel> login(
      LoginRequestModel requestModel) async {
    Uri url = Uri.parse("http://10.0.2.2:8080/login/seller");
    Map<String, String> headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    final response = await http.post(
      url,
      body: jsonEncode(requestModel.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      await storage.write(
          key: "token", value: json.decode(response.body)['token']);

      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    }
  }

   static Future<List<Orders>> fetchOrders(BuildContext context, String token) async {
     
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/orders/seller"),
        headers: {"Authorization": "Bearer " + token});
    List<dynamic> responseJson = json.decode(response.body);
    List<Orders> orders =
    responseJson.map((d) => new Orders.fromJson(d)).toList();
    orders.sort((a, b) {
  return a.orderFulfillmentTime.compareTo(b.orderFulfillmentTime);
});
    if (response.statusCode == 200) {
     
    
      return orders;
    } else {
      return ordersFromJson(response.body);
    }
  }
  

  static Future<http.Response> changeOrderStatus(int oid, String token) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(<String, String>{
        "status": "Order Preparing",
      }),
    );
    if (response.statusCode == 200) {
      print("Order status changed!");
    } else {
      print("Seller status update failed!");
    }
    return response;
  }

  static Future<http.Response> orderRejected(int oid, String token) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(<String, String>{
        "status": "Order Rejected",
      }),
    );
    if (response.statusCode == 200) {
      print("Order status changed to rejected !");
    } else {
      print("Seller status update failed!");
    }
    return response;
  }

  static Future<String> fetchName(BuildContext context, String token) async {
    final response = await http.get(
        Uri.parse("http://10.0.2.2:8080/details/seller"),
        headers: {"Authorization": "Bearer " + token});

    if (response.statusCode == 200) {
      return SellerFromJson(response.body).name;
    } else {
      throw Exception();
    }
  }

  static Future<http.Response> updateAvailable(bool value, String token) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/update/seller"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(<String, bool>{
        'available': value,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Seller availability changed!");
    } else {
      print("Seller Availability update failed!");
    }
    return response;
  }

  static Future<bool> fetchAvail(BuildContext context, String token) async {
    final response = await http.get(
        Uri.parse("http://10.0.2.2:8080/details/seller"),
        headers: {"Authorization": "Bearer " + token});

    if (response.statusCode == 200) {
      return SellerFromJson(response.body).available;
    } else {
      

    }
  }
}