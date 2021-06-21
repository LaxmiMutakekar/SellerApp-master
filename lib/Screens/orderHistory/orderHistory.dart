import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/widgets/coloredBadge.dart';
import 'package:Seller_App/widgets/textOverFlow.dart';
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
  }) : super(
          key: key,
        );

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    final provider = widget.orderProvider;
    List<Orders> completeList = provider.completedOrderList;
    print(completeList.length);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Order History',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: completeList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Orders item = completeList[index];
            if (item.status == 'Order Complete'||item.status=='Order Cancelled') {
              return OrderHistoryCard(order: item);
            } else {
              return Container();
            }
          },
        ));
  }
}

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Orders order;

  @override
  Widget build(BuildContext context) {
    return Cards(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#00000000${order.orderId}',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Container(
                      alignment: Alignment.topRight,
                     // width: 120,
                      child: ColoredBadge(text: order.status==AppConfig.cancelledStatus?'Cancelled':'Completed',color: AppConfig.getColor[order.status])),
                  SizedBox(width: 5),
                  //(order.status=='Order Cancelled')?Text(''):Text(order.fulfilledTime),
                ],
              )
            ],
          ),
          Row(
            children: [
              OverFlowText(
                text: order.orderItemProducts,
                textSize: 12,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  height: 30,
                  width: 100,
                  child: Image.asset("assets/Images/falabellaLogo.png")),
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
                  Text(
                    (order.status==AppConfig.completedStatus)?order.fulfilledTime:'',
                    style: TextStyle(
                        fontSize: 14,
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
