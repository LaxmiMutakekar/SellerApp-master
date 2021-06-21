import 'dart:async';
import 'dart:convert';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/models/errorModel.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/models/sellerDetails.dart';
import 'package:http/http.dart' show Client;
import 'package:Seller_App/session.dart';
import 'package:Seller_App/models/loginModel.dart';
import 'package:Seller_App/models/products.dart';
import 'package:Seller_App/models/statusUpd.dart';

class APIServices {
  static Client client = Client();

  static Future<dynamic> login(LoginRequestModel requestModel) async {
    try {
      Uri url = Uri.parse(AppConfig.baseUrl + "/login/seller");

      final response = await client.post(
        url,
        body: jsonEncode(requestModel.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        Session.token = json.decode(response.body)['token'];
        return LoginResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 401) {
        return LoginResponseModel.fromJson(
          json.decode(response.body),
        );
      }
    } catch (e) {
      return Error(
          timestamp: DateTime.now(),
          message: 'Internal Server Error',
          status: 500,
          path: '/login/seller');
    }
  }

  static Future<dynamic> fetchOrders() async {
    try {
      final response = await client
          .get(Uri.parse(AppConfig.baseUrl + "/orders/seller"), headers: {
        "Authorization": "Bearer " +
            'eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjMyMDcxNTgsImV4cCI6MTYyMzIxNDM1OCwiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJuYW1lIjoiQWJoaXNoZWsiLCJhdmFpbGFibGUiOnRydWV9.R5vWMjdfNeiG6N5ipC4KMSHyZDvJjaxTdS79x0V7DWs'
      });

      if (response.statusCode == 200) {
        List<dynamic> responseJson = json.decode(response.body);
        List<Orders> ordersList =
            responseJson.map((d) => Orders.fromJson(d)).toList();

        ordersList.sort((a, b) {
          return a.orderFulfillmentTime.compareTo(b.orderFulfillmentTime);
        });
        ordersList.sort((a, b) {
          return a.orderPlacedDate.compareTo(b.orderPlacedDate);
        });
        return ordersList;
      } else {
        return Error.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> fetchSeller() async {
    try {
      final response = await client.get(
          Uri.parse(AppConfig.baseUrl + "/details/seller"),
          headers: {"Authorization": "Bearer " + GetToken.tokenValue});
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
      final response = await client.patch(
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
      final response = await client.patch(
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
      final response = await client.patch(
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
      final response = await client.patch(
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

  static Future<bool> addRejectionStatus(
      int oid, String reason, String status) async {
    try {
      final response = await client.patch(
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
      final response = await client.get(
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

  static Future<bool> updateProduct(int index, bool value) async {
    try {
      final response = await client.patch(
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

  static Future<bool> updateSellerDevice(String token) async {
    try {
      final response = await client.patch(
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
