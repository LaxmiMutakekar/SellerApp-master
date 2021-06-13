import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import "package:Seller_App/main.dart";
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

//flutter pub run build_runner buildimport 'loginApi_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {

}