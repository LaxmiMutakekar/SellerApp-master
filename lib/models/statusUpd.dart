// To parse this JSON data, do
//
//     final updateResponse = updateResponseFromJson(jsonString);

import 'dart:convert';

UpdateResponse updateResponseFromJson(String str) => UpdateResponse.fromJson(json.decode(str));

String updateResponseToJson(UpdateResponse data) => json.encode(data.toJson());

class UpdateResponse {
  UpdateResponse({
    this.localDateTime,
    this.response,
  });

  DateTime localDateTime;
  String response;

  factory UpdateResponse.fromJson(Map<String, dynamic> json) => UpdateResponse(
    localDateTime: DateTime.parse(json["localDateTime"]),
    response: json["response"],
  );

  Map<String, dynamic> toJson() => {
    "localDateTime": localDateTime.toIso8601String(),
    "response": response,
  };
}