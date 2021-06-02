import 'package:flutter/material.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/widgets/orderDetail/orderDetails.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:flutter_svg/svg.dart';

import 'activeCard.dart';

class ActiveOrders extends StatefulWidget {
  final OrderProvider orderProvider;
  ActiveOrders({
    Key key,
    this.orderProvider,
  }) : super(
          key: key,
        );
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  DateTime subDt;
  bool visible = false;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.orderProvider;
    List<Orders> activeOrder = provider.activeOrderList;
    if (activeOrder.isEmpty) {
      return Container();
    }
    return Column(
      children: [
        Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Active Orders',
                style: Theme.of(context).textTheme.headline6,
              )),
        ),
        new Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: new TabBar(
            controller: _controller,
            tabs: [
              new Tab(
                text: 'All ',
              ),
              new Tab(
                text: ('Preparing'),
              ),
              new Tab(
                text: 'Ready',
              ),
              new Tab(
                text: 'Delayed',
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: 300 * activeOrder.length.toDouble() ?? 0),
          child: new TabBarView(
            controller: _controller,
            children: <Widget>[
              new Container(
                  child: listOrders(provider, provider.activeOrderList)),
              new Container(
                  child: listOrders(provider, provider.preparingOrderList)),
              new Container(
                  child: listOrders(provider, provider.readyOrderList)),
              new Container(
                  child: listOrders(provider, provider.delayedOrderList)),
            ],
          ),
        ),
      ],
    );
  }

  listOrders(OrderProvider provider, List<Orders> activeOrderList) {
    Orders activeOrder;
    if (activeOrderList.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 32),
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: SvgPicture.asset(
                'assets/Images/sad_panda.svg',
                color: Colors.black45,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'You don\'t have any orders here',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    color: Colors.black45),
              ),
            )
          ],
        ),
      );
    }
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: activeOrderList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          activeOrder = activeOrderList[index];
          return ActiveOrderCard(
            orderProvider: provider,
            activeOrder: activeOrder,
          );
        });
  }
}
