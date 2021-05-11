import 'package:Seller_App/widgets/defaultButton.dart';
import 'package:Seller_App/widgets/ribbon.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/widgets/orderDetails.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders>
    with SingleTickerProviderStateMixin {
  OrderDetail orderItem = new OrderDetail();
  TabController _controller;
  DateTime subDt;
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
                new Container(child: listOrders('All accepted orders')),
                new Container(child: listOrders(AppConfig.acceptStatus)),
                new Container(child: listOrders(AppConfig.markAsDone)),
                new Container(child: listOrders(AppConfig.timeout)),
              ],
            ),
          ),
        ],
      );
    });
  }

  listOrders(chosenValue) {
    return Consumer<Update>(builder: (context, Update orders, child) {
      String url;
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: orders.activeOrders.length,
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Orders active = orders.activeOrders[index];
            switch (active.businessUnit) {
              case 'Sodimac':
                url = 'assets/Images/SodimacLogo.jpeg';
                break;
              case 'Tottus':
                url = 'assets/Images/tottusLogo.jpeg';
                break;
              default:
            }
            if (chosenValue == 'All accepted orders') {
              return activeOrders(active, url, orders, index);
            } else {
              if (active.status == chosenValue) {
                return activeOrders(active, url, orders, index);
              } else {
                return Container();
              }
            }
          });
    });
  }

  activeOrders(Orders active, url, orders, index) {
    DateTime currDt = DateTime.now();
    subDt = active.orderStatusHistory.orderPreparing ?? currDt;
    int diffDt = currDt.difference(subDt).inSeconds;
    bool done = false;
    double dur;
    if (active.orderPreparationTime * 60 >= diffDt.toDouble()) {
      dur = active.orderPreparationTime * 60 - diffDt.toDouble();
    } else
      dur = 0;

    return Consumer<Update>(builder: (context, Update orders, child) {
      return GestureDetector(
        onTap: () {
          orderItem.settingModalBottomSheet(context, active, index);
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
                                    image: new AssetImage(url),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('#00${active.orderId}',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                (active.status == 'Order Preparing')
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Column(
                                          children: [
                                            SlideCountdownClock(
                                              duration: Duration(
                                                  seconds: dur.toInt()),
                                              slideDirection: SlideDirection.Up,
                                              separator: ":",
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              shouldShowDays: false,
                                              onDone: () {
                                                setState(() {
                                                  done = true;
                                                });
                                                orders.activeOrdersUpdate(
                                                    index, AppConfig.timeout);
                                                APIServices.changeOrderStatus(
                                                    active.orderId,
                                                    AppConfig.timeout);
                                              },
                                            ),
                                            Text(
                                              "HH    MM    SS",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container()
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
                          productName(active.orderItems),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          '\$' + active.totalPrice.toInt().toString(),
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
                            active.status == 'Order Preparing'
                                ? Expanded(
                                    child: DefaultButton(
                                      press: () {
                                        orders.activeOrdersUpdate(
                                            index, AppConfig.markAsDone);
                                        APIServices.changeOrderStatus(
                                            active.orderId,
                                            AppConfig.markAsDone);
                                      },
                                      text: ('Mark ready'),
                                    ),
                                  )
                                : SizedBox(width: 0),
                            SizedBox(width: 8),
                            active.status != 'Order Complete'
                                ? Expanded(
                                    child: DefaultButton(
                                        press: () {}, text: ('Update ETC')),
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
                    active.status,
                    style: Theme.of(context).textTheme.button,
                  ),
                  color: active.status == 'Order Ready'
                      ? AppConfig.readyColor
                      : active.status == 'Order Complete'
                          ? AppConfig.completedColor
                          : AppConfig.preparingColor,
                ))
          ]),
        ),
      );
    });
  }
}
