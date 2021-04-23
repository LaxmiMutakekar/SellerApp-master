// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
    Products({
        this.pid,
        this.date,
        this.name,
        this.skuId,
        this.upc,
        this.ean,
        this.image,
        this.description,
        this.price,
        this.available,
        this.basicEta,
    });

    int pid;
    DateTime date;
    String name;
    String skuId;
    String upc;
    String ean;
    String image;
    String description;
    double price;
    bool available;
    int basicEta;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        pid: json["pid"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        skuId: json["sku_id"],
        upc: json["upc"],
        ean: json["ean"],
        image: json["image"],
        description: json["description"],
        price: json["price"],
        available: json["available"],
        basicEta: json["basic_eta"],
    );

    Map<String, dynamic> toJson() => {
        "pid": pid,
        "date": date.toIso8601String(),
        "name": name,
        "sku_id": skuId,
        "upc": upc,
        "ean": ean,
        "image": image,
        "description": description,
        "price": price,
        "available": available,
        "basic_eta": basicEta,
    };
}