import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/updateETC.dart';
import 'package:Seller_App/widgets/coloredBadge.dart';
import 'package:Seller_App/widgets/defaultButton.dart';
import 'package:Seller_App/widgets/textOverFlow.dart';
import 'package:Seller_App/widgets/timer/timer.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/widgets/orderDetails.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:flutter_svg/svg.dart';

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
  OrderDetail orderItem = new OrderDetail();
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

class ActiveOrderCard extends StatelessWidget {
  ActiveOrderCard({
    Key key,
    this.orderProvider,
    this.activeOrder,
  }) : super(key: key);
  OrderProvider orderProvider;
  Orders activeOrder;
  OrderDetail orderDetail = OrderDetail();
  DownTimerController _timerController = DownTimerController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        orderDetail.settingModalBottomSheet(context, activeOrder);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Cards(
            radius: BorderRadius.circular(20),
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#00000000${activeOrder.orderId}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              '\$' + activeOrder.totalPrice.toInt().toString(),
                              style: TextStyle(
                                  color: Color(0xff55B793),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Spacer(),
                        ColoredBadge(
                          text: activeOrder.status,
                          color: activeOrder.status == 'Order Ready'
                              ? AppConfig.readyColor
                              : activeOrder.status == 'Order Preparing'
                                  ? AppConfig.preparingColor
                                  : activeOrder.status == 'Order Timeout'
                                      ? Colors.red[500]
                                      : AppConfig.preparingColor,
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OverFlowText(
                        text: activeOrder.orderItemProducts,
                      ),
                      (activeOrder.status == AppConfig.preparingStatus)
                          ? Column(
                            children: [
                              Container(
                                  width: getProportionateScreenWidth(70),
                                  padding: EdgeInsets.all(3),
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
                                  child: DownTimer(
                                    timerController: _timerController,
                                    timerTextStyle: TimerTextStyle(
                                      uniformTextStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    duration: Duration(
                                        seconds: activeOrder.remSeconds ?? 0),
                                    onComplete: () {
                                      APIServices.changeOrderStatus(
                                          activeOrder, AppConfig.delayedStatus);

                                      orderProvider.activeOrdersUpdate(
                                          activeOrder, AppConfig.delayedStatus);
                                    },
                                  ),
                                ),
                                Text('MM : SS'),
                            ],
                          )
                          : Container()
                    ],
                  ),
                  Row(
                    children: [
                      (activeOrder.status == AppConfig.preparingStatus)
                          ? Expanded(
                              child: DefaultButton(
                                press: () {
                                  orderProvider.activeOrdersUpdate(
                                      activeOrder, AppConfig.raedyStatus);
                                  APIServices.changeOrderStatus(
                                      activeOrder, AppConfig.raedyStatus);
                                },
                                text: ('Mark ready'),
                              ),
                            )
                          : Container(),
                      (activeOrder.status == AppConfig.preparingStatus)
                          ? SizedBox(
                              width: getProportionateScreenWidth(8),
                            )
                          : Container(),
                      (activeOrder.isOrderUpdateEtc)
                          ? Expanded(
                              child: DefaultButton(
                                  press: () async {
                                    updateETC(context).then((res) {
                                      if (res is double) {
                                        updateEtcTime(res);
                                      }
                                    });
                                  },
                                  text: ('Update ETC')),
                            )
                          : Container()
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  void updateEtcTime(double duration) {
    _timerController.updateDuration(
        Duration(seconds: activeOrder.remSeconds + duration.toInt() * 60));
    APIServices.updateETC(activeOrder.orderId, duration.toInt());
    orderProvider.updateETC(activeOrder, duration);
    APIServices.updateButton(activeOrder.orderId);
    orderProvider.updateButton(activeOrder.orderId);
  }
}
