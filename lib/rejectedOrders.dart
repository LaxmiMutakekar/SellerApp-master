import 'package:flutter/material.dart';
import 'package:order_listing/Home.dart';
import 'package:order_listing/drawer.dart';
import 'package:order_listing/mainScreen.dart';
import 'providers/orderUpdate.dart';
import 'models/orders.dart';
import 'package:provider/provider.dart';
import 'widgets/cards.dart';

class RejectedOrders extends StatefulWidget {
  @override
  _RejectedOrdersState createState() => _RejectedOrdersState();
}

class _RejectedOrdersState extends State<RejectedOrders> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Update>(builder: (context, Update orders, child) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffCCCCCD),
          title: Text(
            'Rejected Orders',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          ),
          
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: orders.ordersList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Orders item = orders.ordersList[index];
          if (item.status == 'Order Rejected') {
            return Cards(
              margin: EdgeInsets.symmetric(
                  vertical: 10, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rejected",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[400]),
                  ),
                  Text(
                    '#00${item.orderId}',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black26,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.customer.name,
                        style: TextStyle(
                            fontSize: 15, color: Colors.black)),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      )
    );
             
    });
  }
}
