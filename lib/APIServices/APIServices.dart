import 'dart:async';
import 'dart:convert';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/models/errorModel.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/models/sellerDetails.dart';
import 'package:http/http.dart' as http;
import 'package:Seller_App/session.dart';
import 'package:Seller_App/models/loginModel.dart';
import 'package:Seller_App/models/products.dart';
import 'package:Seller_App/models/statusUpd.dart';

class APIServices {
  static Future<dynamic> login(
      LoginRequestModel requestModel, http.Client client) async {
    try {
      Uri url = Uri.parse(AppConfig.baseUrl + "/login/seller");

      final response = await client.post(
        url,
        body: jsonEncode(requestModel.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print('status =200');
        Session.token = json.decode(response.body)['token'];
        return LoginResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 401) {
        print('status =401');
        return Error.fromJson(
          json.decode(response.body),
        );
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> fetchOrders() async {
    try {
      final response = await http.get(
          Uri.parse(AppConfig.baseUrl + "/orders/seller"),
          headers: {"Authorization": "Bearer " + Session.token});

      List<dynamic> responseJson = json.decode(response.body);
      List<Orders> ordersList =
          responseJson.map((d) => Orders.fromJson(d)).toList();

      ordersList.sort((a, b) {
        return a.orderFulfillmentTime.compareTo(b.orderFulfillmentTime);
      });
      // ordersList.sort((a, b) {
      //   return a.orderPlacedDate.compareTo(b.orderPlacedDate);
      // });

      if (response.statusCode == 200) {
        return ordersList;
      } else {
        return errorFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> fetchSeller() async {
    try {
      final response = await http.get(
          Uri.parse(AppConfig.baseUrl + "/details/seller"),
          headers: {"Authorization": "Bearer " + Session.token});
      if (response.statusCode == 200) {
        return SellerFromJson(response.body);
      }
      if (response.statusCode == 401) {}
    } catch (e) {
      return ('You Are offline');
    }
  }

  static Future<bool> updateAvailable(bool value) async {
    try {
      final response = await http.patch(
        Uri.parse(AppConfig.baseUrl + "/update/seller/available"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + Session.token
        },
        body: jsonEncode(<String, bool>{
          'available': value,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> updateButton(int oid) async {
    try {
      final response = await http.patch(
        Uri.parse(AppConfig.baseUrl +
            "/orders/" +
            oid.toString() +
            "/isOrderUpdateEtc"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + Session.token
        },
        body: jsonEncode(<String, bool>{
          'IsOrderUpdateEtc': false,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> updateETC(Orders order, int duration) async {
    try {
      final response = await http.patch(
        Uri.parse(AppConfig.baseUrl +
            "/orders/" +
            order.orderId.toString() +
            "/OrderUpdateEtc"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + Session.token
        },
        body: jsonEncode(<String, int>{
          'orderUpdateEtc': duration,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> changeOrderStatus(Orders order, String status) async {
    try {
      final response = await http.patch(
        Uri.parse(AppConfig.baseUrl + "/orders/" + order.orderId.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + Session.token
        },
        body: jsonEncode(<String, String>{
          "status": status,
        }),
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        dynamic responseJson = json.decode(response.body);
        UpdateResponse updateResponse = updateResponseFromJson(response.body);
        order.orderPre = updateResponseFromJson(response.body).localDateTime;
        if (status == AppConfig.delayedStatus) {
          order.delayedTime =
              updateResponseFromJson(response.body).localDateTime;
          order.updateButtonStatus = false;
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      print(e);
    }
  }

  static Future<http.Response> addRejectionStatus(
      int oid, String reason, String status) async {
    try {
      final response = await http.patch(
        Uri.parse(AppConfig.baseUrl + "/orders/" + oid.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + Session.token
        },
        body: jsonEncode(<String, String>{
          "status": status,
          "rejectionReason": reason,
        }),
      );
      if (response.statusCode == 200) {

      } else {
        //print("Seller status update failed!");
      }
    } catch (e) {
      print(e);
    }
  }

  // static Future<bool> changeOrderStatus(
  //     Orders order, String status) async {
  //   try {
  //     final response = await http.patch(
  //       Uri.parse(AppConfig.baseUrl + "/orders/" + order.orderId.toString()),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         "status": status,
  //       }),
  //     );
  //     print('accepted status ${response.statusCode}');
  //     if (response.statusCode == 200) {
  //
  //     } else {
  //       //print("Seller status update failed!");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  static Future<List<Products>> fetchProducts() async {
    try {
      final response = await http.get(
          Uri.parse(AppConfig.baseUrl + "/product/seller"),
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
    } catch (e) {
      print(e);
    }
  }

  static Future<http.Response> updateProduct(int index, bool value) async {
    try {
      final response = await http.patch(
        Uri.parse(AppConfig.baseUrl + "/product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + Session.token
        },
        body: jsonEncode(<String, dynamic>{
          'pid': index,
          'available': value,
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<http.Response> updateSellerDevice(String token) async {
    try {
      final response = await http.patch(
        Uri.parse(AppConfig.baseUrl + "/update/seller/device"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + Session.token
        },
        body: jsonEncode(<String, String>{
          "deviceId": token,
        }),
      );
      if (response.statusCode == 200) {
        print("Device token changed!");
      } else {
        print("Seller device token update failed!");
      }
    } catch (e) {
      print(e);
    }
  }
}
