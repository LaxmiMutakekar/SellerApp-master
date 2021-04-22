// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
    Orders({
        this.orderId,
        this.customer,
        this.orderPlacedDate,
        this.status,
        this.businessUnit,
        this.totalPrice,
        this.orderFulfillmentTime,
        this.orderPreparationTime,
        this.orderItems,
    });

    int orderId;
    Customer customer;
    DateTime orderPlacedDate;
    String status;
    String businessUnit;
    double totalPrice;
    double orderFulfillmentTime;
    double orderPreparationTime;
    List<OrderItem> orderItems;

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderId: json["orderId"],
        customer: Customer.fromJson(json["customer"]),
        orderPlacedDate: DateTime.parse(json["orderPlacedDate"]),
        status: json["status"],
        businessUnit: json["businessUnit"],
        totalPrice: json["totalPrice"],
        orderFulfillmentTime: json["orderFulfillmentTime"],
        orderPreparationTime: json["orderPreparationTime"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "customer": customer.toJson(),
        "orderPlacedDate": orderPlacedDate.toIso8601String(),
        "status": status,
        "businessUnit": businessUnit,
        "totalPrice": totalPrice,
        "orderFulfillmentTime": orderFulfillmentTime,
        "orderPreparationTime": orderPreparationTime,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
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
    int basicEtc;
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
