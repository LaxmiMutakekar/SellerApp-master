// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

import 'package:Seller_App/Screens/homeScreen/mainScreen/components/activeCard.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

List<Orders> ordersFromJson(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    this.orderId,
    this.customer,
    this.orderPlacedDate,
    this.status,
    this.businessUnit,
    this.totalPrice,
    this.totalQuantity,
    this.orderFulfillmentTime,
    this.orderPreparationTime,
    this.updatedEtc,
    this.orderItems,
    this.deliveryResource,
    this.orderStatusHistory,
    this.orderUpdateEtc,
    this.isCancelled,
  });

  String get businessLogo {
    switch (this.businessUnit) {
      case 'Sodimac':
        return 'assets/Images/SodimacLogo.jpeg';
      case 'Tottus':
        return 'assets/Images/tottusLogo.jpeg';
      default:
        return "";
    }
  }

  int get updateDelay {
    return (this.orderPreparationTime * 60 ~/ 2);
  }

  set orderPre(DateTime orderprep) =>
      this.orderStatusHistory.orderPreparing = orderprep;
  int orderId;
  Customer customer;
  DateTime orderPlacedDate;
  String status;
  String businessUnit;
  double totalPrice;
  int totalQuantity;
  double orderFulfillmentTime;
  double orderPreparationTime;
  List<OrderItem> orderItems;
  DeliveryResource deliveryResource;
  OrderStatusHistory orderStatusHistory;
  double updatedEtc;
  bool orderUpdateEtc;
  bool isCancelled;
  int get remSeconds {
    var time =
        DateTime.parse(this.orderStatusHistory.orderPreparing.toString());
    var offset = time.add(Duration(
        seconds:
            ((this.orderPreparationTime + this.updatedEtc ?? 0) * 60).toInt() ??
                0));
    var now = DateTime.now();
    return (offset.millisecondsSinceEpoch - now.millisecondsSinceEpoch) ~/ 1000;
  }
  bool get cancelledStatus{
    return this.isCancelled;
  }
  set updateCancelledStatus(bool status){
    this.isCancelled=status;
  }
  String get placedTime {
    return (DateFormat.jm().format(this.orderPlacedDate));
  }

  String get placedAgo {
    var time = DateTime.now().subtract(Duration(
        minutes: this.orderPlacedDate.minute,
        hours: this.orderPlacedDate.hour));
    String agoTime = '';
    if (time.hour != 0) {
      agoTime += time.hour.toString() + ' hour';
      if (time.minute != 0) {
        agoTime += ' ' + time.minute.toString() + ' minutes';
      }
    } else if (time.minute != 0) {
      agoTime += time.minute.toString() + ' minutes';
    } else {
      agoTime += 'Just now';
    }
    if (!agoTime.contains('Just now')) {
      agoTime += ' ago';
    }
    return agoTime;
  }

  set delayedTime(DateTime delayedTime) =>
      this.orderStatusHistory.orderTimeout = delayedTime;

  set updateButtonStatus(bool status) => this.orderUpdateEtc = status;

  int get getDelayedSec {
    if (this.orderStatusHistory.orderTimeout == null) {
      return 0;
    }
    var time = DateTime.parse(this.orderStatusHistory.orderTimeout.toString());
    return DateTime.now().difference(time).inSeconds;
  }

  String get expectedByTime {
    var time = this
        .orderPlacedDate
        .add(Duration(minutes: this.orderFulfillmentTime.toInt()));
    return (DateFormat.jm().format(time));
  }

  String get fulfilledTime {
    var time = DateTime.parse(this.orderStatusHistory.orderHandover);
    return (DateFormat.jm().format(time));
  }

  String get orderItemProducts {
    List<String> productsList = [];
    String products;
    this.orderItems.forEach((element) {
      productsList.add(element.productName);
    });
    (productsList.length > 2)
        ? (products = productsList.getRange(0, 2).join(',').toString() +
            ' ' +
            '&' +
            (productsList.length - 2).toString()  +
            ' more')
        : products = productsList.join(',');

    return products;
  }

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderId: json["orderId"],
        customer: Customer.fromJson(json["customer"]),
        orderPlacedDate: DateTime.parse(json["orderPlacedDate"]),
        status: json["status"],
        businessUnit: json["businessUnit"],
        totalPrice: json["totalPrice"],
        totalQuantity: json["totalQuantity"],
        orderFulfillmentTime: json["orderFulfillmentTime"],
        orderPreparationTime: json["orderPreparationTime"],
        updatedEtc: json["updatedEtc"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        deliveryResource: DeliveryResource.fromJson(json["deliveryResource"]),
        orderStatusHistory:
            OrderStatusHistory.fromJson(json["orderStatusHistory"]),
        orderUpdateEtc: json["orderUpdateEtc"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "customer": customer.toJson(),
        "orderPlacedDate": orderPlacedDate.toIso8601String(),
        "status": status,
        "businessUnit": businessUnit,
        "totalPrice": totalPrice,
        "totalQuantity": totalQuantity,
        "orderFulfillmentTime": orderFulfillmentTime,
        "orderPreparationTime": orderPreparationTime,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "deliveryResource": deliveryResource.toJson(),
        "orderStatusHistory": orderStatusHistory.toJson(),
      };
}

class Customer {
  Customer({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.location,
  });

  String name;
  String email;
  int phone;
  String address;
  Location location;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "location": location.toJson(),
      };
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class DeliveryResource {
  DeliveryResource({
    this.driverName,
    this.phone,
    this.image,
    this.otp,
    this.licenseNumber,
    this.threePlName,
    this.vehicleNumber,
  });

  dynamic driverName;
  int phone;
  dynamic image;
  dynamic otp;
  dynamic licenseNumber;
  dynamic threePlName;
  dynamic vehicleNumber;

  factory DeliveryResource.fromJson(Map<String, dynamic> json) =>
      DeliveryResource(
        driverName: json["driverName"],
        phone: json["phone"],
        image: json["image"],
        otp: json["otp"],
        licenseNumber: json["licenseNumber"],
        threePlName: json["threePLName"],
        vehicleNumber: json["vehicleNumber"],
      );

  Map<String, dynamic> toJson() => {
        "driverName": driverName,
        "phone": phone,
        "image": image,
        "otp": otp,
        "licenseNumber": licenseNumber,
        "threePLName": threePlName,
        "vehicleNumber": vehicleNumber,
      };
}

class OrderItem {
  OrderItem({
    this.upc,
    this.image,
    this.price,
    this.skuId,
    this.itemId,
    this.quantity,
    this.basicEtc,
    this.description,
    this.productName,
  });

  String upc;
  String image;
  double price;
  String skuId;
  int itemId;
  int quantity;
  double basicEtc;
  String description;
  String productName;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        upc: json["upc"],
        image: json["image"],
        price: json["price"],
        skuId: json["skuId"],
        itemId: json["itemId"],
        quantity: json["quantity"],
        basicEtc: json["basic_etc"],
        description: json["description"],
        productName: json["productName"],
      );

  Map<String, dynamic> toJson() => {
        "upc": upc,
        "image": image,
        "price": price,
        "skuId": skuId,
        "itemId": itemId,
        "quantity": quantity,
        "basic_etc": basicEtc,
        "description": description,
        "productName": productName,
      };
}

class OrderStatusHistory {
  OrderStatusHistory({
    this.orderPreparing,
    this.orderReady,
    this.orderTimeout,
    this.orderHandover,
    this.orderFulfilled,
  });

  dynamic orderPreparing;
  dynamic orderReady;
  dynamic orderTimeout;
  dynamic orderHandover;
  dynamic orderFulfilled;

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) =>
      OrderStatusHistory(
        orderPreparing: (json["orderPreparing"]),
        orderReady: (json["orderPreparing"]),
        orderTimeout: (json["orderPreparing"]),
        orderHandover: (json["orderPreparing"]),
        orderFulfilled: (json["orderPreparing"]),
      );

  Map<String, dynamic> toJson() => {
        "orderPreparing": orderPreparing,
        "orderReady": orderReady,
        "orderTimeout": orderTimeout,
        "orderHandover": orderHandover,
        "orderFulfilled": orderFulfilled,
      };
}
