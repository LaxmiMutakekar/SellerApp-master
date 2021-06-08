import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/pendingOrder/pendingOrderCard.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/widgets/orderDetail/orderDetails.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:flutter_svg/svg.dart';

class PendingOrders extends StatelessWidget {
  final OrderProvider orderProvider;

  PendingOrders({
    Key key,
    this.orderProvider,
  }) : super(
          key: key,
        );
  OrderDetail orderItem;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    OrderProvider provider = orderProvider;
    List<Orders> pendingOrder = provider.pendingOrderList;
    if (pendingOrder.isEmpty) {
      return Container(
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              child: SvgPicture.asset(
                'assets/Images/sad_panda.svg',
                color: Colors.black45,
              ),
            ),
            Text(
              AppConfig.noPendingOrders,
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: getProportionateScreenHeight(222),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pending Orders',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pendingOrder.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Orders order = pendingOrder[index];
                  orderItem = OrderDetail(order);
                  return PendingOrderCard(
                      pendingOrder: order, provider: provider);
                }),
          ),
        ],
      ),
    );
  }
}
