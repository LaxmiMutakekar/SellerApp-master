import 'dart:convert';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/session.dart';
import 'package:Seller_App/widgets/orderDetail/orderDetails.dart';
import 'package:Seller_App/widgets/textOverFlow.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:http/http.dart' as http;

class RejectedOrders extends StatefulWidget {
  static String routeName = "/rejectedOrder";
  final OrderProvider orderProvider;

  RejectedOrders({
    Key key,
    this.orderProvider,
  }) : super(
          key: key,
        );

  @override
  _RejectedOrdersState createState() => _RejectedOrdersState();
}

class _RejectedOrdersState extends State<RejectedOrders> {
  int days = 1;
  int selectedValue = 1;
  List<Orders> lastRejected = [];

  Future<List<Orders>> fetchOrders(int i) async {
    lastRejected.clear();
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:8080/orders/seller"),
          headers: {"Authorization": "Bearer " + Session.token});
      List<dynamic> responseJson = json.decode(response.body);
      List<Orders> ordersList =
          responseJson.map((d) => new Orders.fromJson(d)).toList();
      ordersList.forEach((element) {
        if (element.orderPlacedDate
                .isAfter(DateTime.now().subtract(Duration(days: i))) &&
            element.status == 'Order Rejected') {
          setState(() {
            lastRejected.add(element);
          });
        }
      });
      if (response.statusCode == 200) {
        return lastRejected;
      } else {
        return ordersFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders(days);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (context, OrderProvider orders, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Rejected Orders',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            actions: [
              DropdownButton(
                  iconEnabledColor: Colors.black,
                  focusColor: Colors.white,
                  value: selectedValue,
                  items: [
                    DropdownMenuItem(
                      onTap: () {
                        setState(() {
                          days = 1;
                        });
                      },
                      child: Text(
                        "Today",
                        textAlign: TextAlign.center,
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      onTap: () {
                        setState(() {
                          days = 2;
                        });
                      },
                      child: Text("Last two days"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      onTap: () {
                        setState(() {
                          days = 5;
                        });
                      },
                      child: Text("Last five days"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            days = 10;
                          });
                        },
                        child: Text("Last ten days"),
                        value: 4),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                    fetchOrders(days);
                  }),
            ],
          ),
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: lastRejected.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Orders item = lastRejected[index];
                    if (item.status == 'Order Rejected') {
                      return GestureDetector(
                        onTap: () {
                          // orderItem.settingModalBottomSheet(context);
                        },
                        child: RejectedOrderCard(order: item),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ));
    });
  }
}

class RejectedOrderCard extends StatelessWidget {
  const RejectedOrderCard({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Orders order;

  format(Duration d) => d.toString().substring(2, 7);

  @override
  Widget build(BuildContext context) {
    return Cards(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#00000000${order.orderId}',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  OverFlowText(
                    text: order.orderItemProducts,
                    textSize: 12,
                  )
                ],
              ),
              Text(
                '@' + order.placedTime,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  boxShadow: [
                    // to make elevation
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 20,
                    ),
                    // to make the coloured border
                  ],
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Unavailable',
                  style: TextStyle(
                      color: Colors.red[300], fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Text(
                    '\$${order.totalPrice}',
                    style: TextStyle(
                        color: Colors.teal[300],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Order amount',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
