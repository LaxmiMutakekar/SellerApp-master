// import 'dart:convert';
//
// import 'package:Seller_App/APIServices/APIServices.dart';
// import 'package:Seller_App/models/loginModel.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart'as http;
//
// import 'loginApi_test.mocks.dart';
//
// class MockAPIServices extends Mock implements APIServices{
//   static Future<dynamic>login(){
//     final client = MockClient();
//     Uri url = Uri.parse("http://10.0.2.2:8080 /login/seller");
//     LoginRequestModel requestModel =
//     LoginRequestModel(email: "Abhishek@gmail.com", password: "abhishek");
//     LoginRequestModel errorModel ;
//       when(client.post(
//         url,
//         body: jsonEncode(requestModel.toJson()),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       )).thenAnswer((_) async =>
//           http.Response(
//               '{"response": "Login Successful!", "token":"eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjM2MDE4NTMsImV4cCI6MTYyMzYwOTA1MywiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJuYW1lIjoiQWJoaXNoZWsiLCJhdmFpbGFibGUiOnRydWV9.irOj7nY8fe0VDOMMOGBk5_NhKHPy1ySxnI4D3iw1h3g" }',
//               200));
//     when(client.post(
//       url,
//       body: jsonEncode(requestModel.toJson()),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//     )).thenAnswer((_) async =>
//         http.Response(
//             '{"response": "Login Successful!", "token":"eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjM2MDE4NTMsImV4cCI6MTYyMzYwOTA1MywiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJuYW1lIjoiQWJoaXNoZWsiLCJhdmFpbGFibGUiOnRydWV9.irOj7nY8fe0VDOMMOGBk5_NhKHPy1ySxnI4D3iw1h3g" }',
//             200));
//   }
// }
// void main() {
//   testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
//     // Test code goes here.
//     //await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
//   });
// }