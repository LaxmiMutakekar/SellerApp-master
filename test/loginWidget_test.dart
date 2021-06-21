import 'package:Seller_App/Screens/homeScreen/Home.dart';
import 'package:Seller_App/Screens/loginScreen/components/loginBody.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('LoginScreen', () {
    testWidgets(
        'Login Screen email and password field gives text for user inputs',
        (WidgetTester tester) async {
      //Assign
      await tester
          .pumpWidget(MaterialApp(home: LoginBody(isApiCallProcess: false)));
      //Act
      await tester.enterText(find.byKey(Key('email')), 'abhishek@gmail.com');
      await tester.enterText(find.byKey(Key('Password')), 'abhishek');
      await tester.tap(find.byKey(Key('hidePassword')));
      await tester.tap(find.byKey(Key('LoginButton')));
      await tester.pump();
      //Assert
      expect(find.text('abhishek@gmail.com'), findsOneWidget);
      expect(find.text('abhishek'), findsOneWidget);
    });
    testWidgets(
        'Login Screen when entered with correct email and password shows a success snack bar ',
        (WidgetTester tester) async {
      //Assign
      await tester
          .pumpWidget(MaterialApp(home: LoginBody(isApiCallProcess: false)));
      //Act
      await tester.enterText(find.byKey(Key('email')), 'abhishek@gmail.com');
      await tester.enterText(find.byKey(Key('Password')), 'abhishek');
      APIServices.client = MockClient((request) async {
        return http.Response(
            '{"response": "Login Successful!", "token":"eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjM2MDE4NTMsImV4cCI6MTYyMzYwOTA1MywiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJuYW1lIjoiQWJoaXNoZWsiLCJhdmFpbGFibGUiOnRydWV9.irOj7nY8fe0VDOMMOGBk5_NhKHPy1ySxnI4D3iw1h3g" }',
            200);
      });
      await tester.tap(find.byKey(Key('LoginButton')));
      await tester.pump();
      //Assert
      expect(find.text('Login Successful'), findsOneWidget);
    });
    testWidgets(
        'Login Screen when entered with wrong email and password shows a error text in snack bar ',
        (WidgetTester tester) async {
      //Assign
      await tester
          .pumpWidget(MaterialApp(home: LoginBody(isApiCallProcess: false)));
      //Act
      await tester.enterText(find.byKey(Key('email')), 'abhishek@gmail.com');
      await tester.enterText(find.byKey(Key('Password')), 'abhishek');
      APIServices.client = MockClient((request) async {
        return http.Response(
            '{"response": "Login Failed!", "message":"Invalid email/password" }',
            401);
      });
      await tester.tap(find.byKey(Key('LoginButton')));
      await tester.pump();
      //Assert
      expect(find.text('Invalid email/password'), findsOneWidget);
    });
  });
}
