import 'dart:convert';

import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/models/errorModel.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/models/sellerDetails.dart';
import 'package:Seller_App/session.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

main() {
  group('fetchOrder method test', () {
    test('returns Orders for successful API call', () async {
      final client = MockClient();
      APIServices.client = client;
      List<Orders> order = [];
      OrderItem orderItem = OrderItem(
          upc: "048052832821",
          image:
              "https://i1.wp.com/www.eatthis.com/wp-content/uploads/2020/01/dal.jpg?w=1200&ssl=1",
          price: 9.0,
          skuId: "DALPG3",
          itemId: 1,
          basicEtc: 10.0,
          quantity: 1,
          description:
              " Depending where you order dal, you might be served a thinner soup-like bowl of lentils, or something more akin to a stew that comes with a side of rice",
          productName: "Dal");
      List<OrderItem> orderItems = [];
      orderItems.add(orderItem);
      Orders orders = Orders(
          orderId: 1,
          customer: Customer(
              name: 'Namitha',
              email: 'namitha2yahoo.com',
              phone: 1234567890,
              address: "Chennai",
              location: Location(latitude: 15.824883, longitude: 15.824883)),
          orderPlacedDate: DateTime.now(),
          status: 'Order Placed',
          businessUnit: 'Tottus',
          totalPrice: 130.0,
          totalQuantity: 3,
          orderFulfillmentTime: 120,
          orderPreparationTime: 10,
          updatedEtc: 0.0,
          orderItems: orderItems,
          deliveryResource: DeliveryResource(
              driverName: "Ramesh",
              phone: 123456789,
              image:
                  "https://raw.githubusercontent.com/LaxmiMutakekar/SellerApp-master/master/assets/pizza.jpeg",
              otp: "123456",
              vehicleNumber: "CLEEUB2466",
              licenseNumber: "1234EZKE",
              threePlName: "Chazki"),
          orderStatusHistory: OrderStatusHistory(
              orderPreparing: "2021-06-18T09:17:38.893721",
              orderReady: "2021-06-18T09:17:58.739563",
              orderTimeout: null,
              orderHandover: null,
              orderFulfilled: null),
          orderUpdateEtc: false);
      order.add(orders);
      when(
          client.get(Uri.parse(AppConfig.baseUrl + "/orders/seller"), headers: {
        "Authorization": "Bearer " +
            'eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjMyMDcxNTgsImV4cCI6MTYyMzIxNDM1OCwiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJuYW1lIjoiQWJoaXNoZWsiLCJhdmFpbGFibGUiOnRydWV9.R5vWMjdfNeiG6N5ipC4KMSHyZDvJjaxTdS79x0V7DWs'
      })).thenAnswer((_) async => http.Response(ordersToJson(order), 200));
      expect(await APIServices.fetchOrders(), isA<List<Orders>>());
    });
    test('returns ErrorModel for unsuccessful API call', () async {
      final client = MockClient();
      APIServices.client = client;
      Error errorResponse = Error(
          timestamp: DateTime.now(),
          status: 401,
          error: "Unauthorized",
          message: "invalid/expired token",
          path: "/orders/seller");
      when(
          client.get(Uri.parse(AppConfig.baseUrl + "/orders/seller"), headers: {
        "Authorization": "Bearer " +
            'eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjMyMDcxNTgsImV4cCI6MTYyMzIxNDM1OCwiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJuYW1lIjoiQWJoaXNoZWsiLCJhdmFpbGFibGUiOnRydWV9.R5vWMjdfNeiG6N5ipC4KMSHyZDvJjaxTdS79x0V7DWs'
      })).thenAnswer(
          (_) async => http.Response(errorToJson(errorResponse), 401));
      expect(await APIServices.fetchOrders(), isA<Error>());
    });
  });
  test("fetch seller information", () async {
    Seller seller = Seller(
        name: "Abhishek",
        date: DateTime.now(),
        email: "abhishek@gmail.com",
        available: true,
        shortName: "Master Cheif Kitchen",
        phone: "9148301122",
        type: "Restaurant",
        deviceId:
            "cRW25HIUSNmR9k-FFUkWND:APA91bGrtjA0WRadEcrQGbTdcoytpS979VVY8PSaV3DgVh8yTaJkL13knbM1HOzlN_VJ8vFACTXFxsLM3ipcrfKQ8lFep9o8pj-_bbnuRbswKbsWMlN_yCZP-xYquGHol2r-InFOOl_Y",
        location: Location(longitude: 12.3311, latitude: 13.322));
    final client = MockClient();
    APIServices.client = client;
    GetToken.tokenValue='cRW25HIUSNmR9k-FFUkWND:APA91bGrtjA0WRadEcrQGbTdcoytpS979VVY8PSaV3DgVh8yTaJkL13knbM1HOzlN_VJ8vFACTXFxsLM3ipcrfKQ8lFep9o8pj-_bbnuRbswKbsWMlN_yCZP-xYquGHol2r-InFOOl_Y';
    when(client.get(Uri.parse(AppConfig.baseUrl + "/details/seller"),
            headers: {"Authorization": "Bearer " + GetToken.tokenValue}))
        .thenAnswer((_) async => http.Response(SellerToJson(seller), 200));
    expect(await APIServices.fetchSeller(), isA<Seller>());
  });
}
