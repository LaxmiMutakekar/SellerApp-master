// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
    Error({
        this.timestamp,
        this.status,
        this.error,
        this.message,
        this.path,
    });

    DateTime timestamp;
    int status;
    String error;
    String message;
    String path;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        error: json["error"],
        message: json["message"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "error": error,
        "message": message,
        "path": path,
    };
}
