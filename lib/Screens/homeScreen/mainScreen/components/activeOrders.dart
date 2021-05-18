import 'package:Seller_App/Screens/homeScreen/mainScreen/components/updateETC.dart';
import 'package:Seller_App/widgets/defaultButton.dart';
import 'package:Seller_App/widgets/ribbon.dart';
import 'package:Seller_App/widgets/timer/timer.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/widgets/orderDetails.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/providers/orderUpdate.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders>
    with SingleTickerProviderStateMixin {
  OrderDetail orderItem = new OrderDetail();
  TabController _controller;
  DateTime subDt;
  bool visible = false;
  DateTime currDt;
   DownTimerController _timerController = DownTimerController();
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Update>(builder: (context, Update orders, child) {
      if (orders.activeOrders.isEmpty) {
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
                  text: 'All orders',
                ),
                new Tab(
                  text: ('Preparing'),
                ),
                new Tab(
                  text: 'Ready',
                ),
                new Tab(
                  text: 'Timedout',
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            padding: EdgeInsets.only(top: 10),
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[
                new Container(child: listOrders(orders, 'All accepted orders')),
                new Container(
                    child: listOrders(orders, AppConfig.acceptStatus)),
                new Container(child: listOrders(orders, AppConfig.markAsDone)),
                new Container(child: listOrders(orders, AppConfig.timeout)),
              ],
            ),
          ),
        ],
      );
    });
  }

  listOrders(Update provider, chosenValue) {
    String url;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: provider.activeOrders.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Orders active = provider.activeOrders[index];

          if (chosenValue == 'All accepted orders') {
            return activeOrders(provider, active);
          } else {
            if (active.status == chosenValue) {
              return activeOrders(
                provider,
                active,
              );
            } else {
              return Container();
            }
          }
        });
  }

  activeOrders(Update provider, Orders order) {
   
    return GestureDetector(
      onTap: () {
         orderItem.settingModalBottomSheet(context, order);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Cards(
              radius: BorderRadius.circular(20),
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.hardEdge,
                                width: 60,
                                height: 60,
                                child: Image(
                                  image: new AssetImage(order.businessLogo),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('#00${order.orderId}',
                                  style: Theme.of(context).textTheme.headline6),
                                   Visibility(
                                    visible: (order.status == 'Order Preparing'),
                                                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Column(
                                          children: [
                                            DownTimer(
                                              timerController: _timerController,
                                              // showLabels: true,
                                              timerTextStyle: TimerTextStyle(
                                                uniformTextStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              duration: Duration(seconds: order.remSeconds??0),
                                              onComplete: () {
                                                APIServices.changeOrderStatus(order, AppConfig.timeout);
                                                //print('completed');
                                                provider.activeOrdersUpdate(order, AppConfig.timeout);
                                              },
                                            ),
                                            Text(
                                              "MM  SS",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                  )
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        productName(order.orderItems),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '\$' + order.totalPrice.toInt().toString(),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).dividerColor),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          
                               Visibility(
                                visible: order.status == 'Order Preparing',
                                                              child: Expanded(
                                    child: DefaultButton(
                                      press: () {
                                        provider.activeOrdersUpdate(
                                            order, AppConfig.markAsDone);
                                        APIServices.changeOrderStatus(
                                            order, AppConfig.markAsDone);
                                      },
                                      text: ('Mark ready'),
                                    ),
                                  ),
                              ),
                          SizedBox(width: 8),
                          order.status != 'Order Complete'
                              ? Visibility(
                                  visible: order.updateFlag ?? true,
                                  child: Expanded(
                                    child: DefaultButton(
                                        press: () async {
                                          updateETC(context).then((res) {
                                            if (res is double) {
                                              //print('res value $res');
                                              _timerController.updateDuration(Duration(seconds: order.remSeconds+res.toInt()*60));
                                              provider.updateETC(order, res);
                                              provider.updateButton(order);
                                            }
                                          });
                                        },
                                        text: ('Update ETC')),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 3,
              top: 30,
              child: RibbonShape(
                child: Text(
                  order.status,
                  style: Theme.of(context).textTheme.button,
                ),
                color: order.status == 'Order Ready'
                    ? AppConfig.readyColor
                    : order.status == 'Order Complete'
                        ? AppConfig.completedColor
                        : order.status == 'Order Timeout'
                            ? Colors.red[500]
                            : AppConfig.preparingColor,
              ))
        ]),
      ),
    );
  }

  onEnd(Update provider, Orders order) {
    provider.activeOrdersUpdate(order, AppConfig.timeout);
    APIServices.changeOrderStatus(order, AppConfig.timeout);
  }
}
