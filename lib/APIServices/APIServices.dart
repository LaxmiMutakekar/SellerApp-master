import 'dart:async';
import 'dart:convert';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/models/sellerDetails.dart';
import 'package:http/http.dart' as http;
import 'package:Seller_App/session.dart';
import 'package:Seller_App/models/loginModel.dart';
import 'package:Seller_App/models/products.dart';

class APIServices {
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

    //print(response.statusCode);
    if (response.statusCode == 200) {
      Session.token = json.decode(response.body)['token'];
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  static Future<List<Orders>> fetchOrders() async {
    final response = await http.get(
        Uri.parse("http://10.0.2.2:8080/orders/seller"),
        headers: {"Authorization": "Bearer " + Session.token});
    List<dynamic> responseJson = json.decode(response.body);
    List<Orders> ordersList =
        responseJson.map((d) => new Orders.fromJson(d)).toList();
    ordersList.sort((a, b) {
      return a.orderFulfillmentTime.compareTo(b.orderFulfillmentTime);
    });
    if (response.statusCode == 200) {
      return ordersList;
    } else {
      return ordersFromJson(response.body);
    }
  }

  static Future<Seller> fetchSeller() async {
    final response = await http.get(
        Uri.parse("http://10.0.2.2:8080/details/seller"),
        headers: {"Authorization": "Bearer " + Session.token});
    if (response.statusCode == 200) {
      return SellerFromJson(response.body);
    }
    if (response.statusCode == 401) {
      //print('error');
    }

    return SellerFromJson(response.body);
  }

  static Future<http.Response> updateAvailable(bool value) async {
    final response = await http.patch(
      Uri.parse("http://10.0.2.2:8080/update/seller/available"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, bool>{
        'available': value,
      }),
    );
    if (response.statusCode == 200) {
      //print("Seller availability changed!");
    } else {
      //print("Seller Availability update failed!");
    }
    return response;
  }

  static Future<http.Response> changeOrderStatus(int oid, String status) async {
    final response = await http.patch(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, String>{
        "status": status,
      }),
    );
    if (response.statusCode == 200) {
      //print("Order status changed!");
    } else {
      //print("Seller status update failed!");
    }
    return response;
  }
  static Future<http.Response> addRejectionStatus(int oid, String reason,String status) async {
    final response = await http.patch(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, String>{
        "status": status,
        "rejectionReason":reason,
      }),
    );
    if (response.statusCode == 200) {
      //print("Order status changed!");
    } else {
      //print("Seller status update failed!");
    }
    return response;
  }

  static Future<List<Products>> fetchProducts() async {
    final response = await http.get(
        Uri.parse("http://10.0.2.2:8080/product/seller"),
        headers: {"Authorization": "Bearer " + Session.token});
    List<dynamic> responseJson = json.decode(response.body);
    List<Products> products =
        responseJson.map((d) => new Products.fromJson(d)).toList();
    if (response.statusCode == 200) {
      //print(products);
      return products;
    } else {
      return productsFromJson(response.body);
    }
  }

  static Future<http.Response> updateProduct(int index, bool value) async {
    final response = await http.patch(
      Uri.parse("http://10.0.2.2:8080/product"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, dynamic>{
        'pid': index,
        'available': value,
      }),
      
    );
    return response;
  }
  static Future<http.Response> updateSellerDevice(String token) async {
    final response = await http.patch(
      Uri.parse("http://10.0.2.2:8080/update/seller/device" ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, String>{
        "deviceId":token,
      }),
    );
    if (response.statusCode == 200) {
      print("Device token changed!");
    } else {
      print("Seller device token update failed!");
    }
    return response;
  }

}
