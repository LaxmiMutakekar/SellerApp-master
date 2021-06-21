import 'dart:convert';

import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/loginModel.dart';
import 'package:Seller_App/models/sellerDetails.dart';
import 'package:Seller_App/session.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.

@GenerateMocks([http.Client])
void main() {
  group('loginAPI', () {
    test('returns token if the http call completes successfully', () async {
      LoginRequestModel requestModel =
          LoginRequestModel(email: "Abhishek@gmail.com", password: "abhishek");

      APIServices.client = MockClient((request) async {
        return http.Response(
            '{"response": "Login Successful!", "token":"eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjM2MDE4NTMsImV4cCI6MTYyMzYwOTA1MywiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJuYW1lIjoiQWJoaXNoZWsiLCJhdmFpbGFibGUiOnRydWV9.irOj7nY8fe0VDOMMOGBk5_NhKHPy1ySxnI4D3iw1h3g" }',
            200);
      });
      expect(await APIServices.login(requestModel), isA<LoginResponseModel>());
    });

    test('throws an error if the login call completes with an error', () async {
      LoginRequestModel requestModel =
          LoginRequestModel(email: "Abhisek@gmail.com", password: "abhshek");
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.

      APIServices.client = MockClient((request) async {
        return http.Response(
            '{"response": "Login Failed!", "message":"Invalid email/password" }',
            401);
      });
      expect(
          await APIServices.login(
            LoginRequestModel(
                email: "Abhisek@gmail.com", password: "abhsheeek"),
          ),
          isA<LoginResponseModel>());
    });

  });

}
