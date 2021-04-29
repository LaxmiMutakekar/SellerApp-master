import 'dart:convert';

Seller SellerFromJson(String str) => Seller.fromJson(json.decode(str));

String SellerToJson(Seller data) => json.encode(data.toJson());

class Seller {
    Seller({
         this.name,
        this.date,
        this.email,
        this.available,
        this.shortName,
        this.phone,
        this.type,
        this.deviceId,
        this.location,
    });

    String name;
    DateTime date;
    String email;
    bool available;
    String shortName;
    String phone;
    String type;
    String deviceId;
    Location location;

     factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        name: json["name"],
        date: DateTime.parse(json["date"]),
        email: json["email"],
        available: json["available"],
        shortName: json["shortName"],
        phone: json["phone"],
        type: json["type"],
        deviceId: json["deviceId"],
        location: Location.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "date": date.toIso8601String(),
        "email": email,
        "available": available,
        "shortName": shortName,
        "phone": phone,
        "type": type,
        "deviceId": deviceId,
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
