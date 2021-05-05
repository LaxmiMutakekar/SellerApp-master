import 'package:flutter/material.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/widgets/cards.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Update>(builder: (context, Update orders, child) {
      return Scaffold(
          appBar: AppBar(
            //backgroundColor: Color(0xffCCCCCD),
            title: Text(
              'Orders History',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          //backgroundColor: Colors.grey[300],
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: orders.completedOrders.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Orders item = orders.completedOrders[index];
              if (item.status == 'Order Complete') {
                return Cards(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Complete",
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
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ));
    });
  }
}