import 'dart:convert';

import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/loginModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import "package:Seller_App/main.dart";

//import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'loginApi_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('loginAPI', () {
    test('returns token if the http call completes successfully', () async {
      final client = MockClient();
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      Uri url = Uri.parse("http://10.0.2.2:8080 " + "/login/seller");

      LoginRequestModel requestModel =
          LoginRequestModel(email: "Abhishek@gmail.com", password: "abhishek");
      when(client.post(
        url,
        body: jsonEncode(requestModel.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      )).thenAnswer((_) async => http.Response(
          '{"response": "Login Successful!", "token":"eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjM2MDE4NTMsImV4cCI6MTYyMzYwOTA1MywiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJuYW1lIjoiQWJoaXNoZWsiLCJhdmFpbGFibGUiOnRydWV9.irOj7nY8fe0VDOMMOGBk5_NhKHPy1ySxnI4D3iw1h3g" }',
          200));

      expect(await APIServices.login(requestModel, client),
          isA<LoginResponseModel>());
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();
      Uri url = Uri.parse("http://10.0.2.2:8080 " + "/login/seller");
      Map<String, String> headers = {
        "Accept": "application/json",
        "content-type": "application/json"
      };
      LoginRequestModel requestModel =
          LoginRequestModel(email: "Abhisek@gmail.com", password: "abhshek");
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.post(
        url,
        body: jsonEncode(requestModel),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      )).thenAnswer((_) async => http.Response(
          '{"timeStamp": "2021-06-13T16:39:01.819+00:00", "status":401,"error": "Unauthorized","message": "Invalid email/password","path": "/login/seller" }',
          401));
      expect(
          await APIServices.login(
              LoginRequestModel(
                  email: "Abhisek@gmail.com", password: "abhsheeek"),
              client),
          isA<Error>());
    });
  });
}
