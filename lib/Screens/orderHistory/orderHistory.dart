import 'package:flutter/material.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/widgets/cards.dart';

class OrderHistory extends StatefulWidget {
  static String routeName = "/orderHistory";
   final OrderProvider orderProvider;
  OrderHistory({
    Key key,
     this.orderProvider,
  }) : super(key: key,);
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
   final provider=widget.orderProvider;
   List<Orders> completeList=provider.completedOrderList;
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Orders History',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: completeList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Orders item = completeList[index];
              if (item.status == 'Order Complete') {
                return Cards(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
  }
}
