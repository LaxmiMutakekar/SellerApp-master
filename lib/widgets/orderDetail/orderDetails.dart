import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/activeOrderButtons.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/countDownTimer.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/pendingOrder/buttons.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/widgets/upCounter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:provider/provider.dart';
import '../coloredBadge.dart';

import 'defaultOrderDetail.dart';

class OrderDetail {
  Orders order;
  CountDownTimer countDown;

  OrderDetail(this.order);

  set setTimer(CountDownTimer timer) {
    countDown = timer;
  }

  @override
  void settingModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Consumer<OrderProvider>(
              builder: (context, OrderProvider provider, child) {
            countDown = CountDownTimer(provider, order);
            return SingleChildScrollView(
              child: (order.status == AppConfig.pendingStatus)
                  ? pendingOrderBottomSheet(context, provider)
                  : activeOrderBottomSheet(context, provider),
            );
          });
        });
  }

  pendingOrderBottomSheet(BuildContext context, OrderProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(120),
                height: getProportionateScreenWidth(30),
                child: ColoredBadge(
                  text: order.status,
                  color: AppConfig.getColor[order.status],
                ),
              ),
              Text(order.timePassedFromPlaced),
            ],
          ),
          const Divider(
            height: 17,
            thickness: 2,
            //color: Color(0xff393E43),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#00000000" + order.orderId.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              Column(
                children: [
                  Text(
                    order.expectedByTime,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff9E545E),
                    ),
                  ),
                  Text(
                    'Expected by',
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 17,
            thickness: 2,
            //color: Color(0xff393E43),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 350, minHeight: 200),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DefaultOrderDetail(order: order),
                ],
              ),
            ),
          ),
          Container(
              child: PendingOrderButtons(
            provider: provider,
            pendingOrder: order,
          )),
        ],
      ),
    );
  }

  activeOrderBottomSheet(BuildContext context, OrderProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(120),
                height: getProportionateScreenWidth(30),
                child: ColoredBadge(
                  text: order.status,
                  color: AppConfig.getColor[order.status],
                ),
              ),
              Column(children: [
                (order.status == AppConfig.preparingStatus)
                    ? countDown.countDownTimer
                    : Container(),
                (order.status == AppConfig.preparingStatus)
                    ? Text('Time left')
                    : Container(),
                (order.status == AppConfig.delayedStatus)
                    ? UpCounter(order: order)
                    : Container(),
                (order.status == AppConfig.delayedStatus)
                    ? Text('Delayed by')
                    : Container(),
              ])
            ],
          ),
          const Divider(
            height: 17,
            thickness: 2,
          ),
          // (order.status == AppConfig.preparingStatus)
          //     ? CountDownTimer(order: order, provider: provider)
          //     : (order.status == AppConfig.delayedStatus)
          //         ? UpCounter(
          //             order: order,
          //           )
          //         : Container(),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 200, maxHeight: 350),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#00000000" + order.orderId.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Column(
                        children: [
                          Text(
                            order.expectedByTime,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff9E545E),
                            ),
                          ),
                          Text(
                            'Expected by',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 17,
                    thickness: 2,
                  ),
                  (order.deliveryResource.driverName != null)
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            order.deliveryResource.driverName
                                                .toString()
                                                .trim(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2),
                                        Text("Delivery person"),
                                      ],
                                    ),
                                    Icon(Icons.expand_more),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      order.deliveryResource.vehicleNumber,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xff9E545E),
                                      ),
                                    ),
                                    Text(
                                      'Vehicle number',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              height: 17,
                              thickness: 2,
                            ),
                          ],
                        )
                      : Container(),
                  DefaultOrderDetail(order: order),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen({this.order, this.provider});

  final Orders order;
  final OrderProvider provider;
  CountDownTimer countDown;

  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (context, OrderProvider provider, child) {
      countDown = CountDownTimer((provider), order);
      return Hero(
        tag: order.orderId,
        child: Align(
          alignment: Alignment.center,
          child: Material(
            child: SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "#00000000" + order.orderId.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(fontSize: 15),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(140),
                                  height: getProportionateScreenWidth(30),
                                  child: ColoredBadge(
                                    text: order.status,
                                    color: AppConfig.getColor[order.status],
                                  ),
                                ),
                              ],
                            ),
                            (order.status == AppConfig.pendingStatus)
                                ? Text(order.timePassedFromPlaced)
                                : Column(children: [
                                    (order.status == AppConfig.preparingStatus)
                                        ? countDown.countDownTimer
                                        : Container(),
                                    (order.status == AppConfig.delayedStatus)
                                        ? UpCounter(order: order)
                                        : Container(),
                                  ]),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 390, minHeight: 390),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.grey[300],
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(order.customer.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                size: 16,
                                              ),
                                              SizedBox(width: 5),
                                              Opacity(
                                                  opacity: 0.60,
                                                  child: Text(order
                                                      .timePassedFromPlaced)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            order.expectedByTime,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color(0xff9E545E),
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.60,
                                            child: Text(
                                              'Expected by',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              (order.deliveryResource.driverName != null)
                                  ? Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        order.deliveryResource
                                                            .driverName
                                                            .toString()
                                                            .trim(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2),
                                                    Text("Delivery person"),
                                                  ],
                                                ),
                                                Icon(Icons.expand_more),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  order.deliveryResource
                                                      .vehicleNumber,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Color(0xff9E545E),
                                                  ),
                                                ),
                                                Text(
                                                  'Vehicle number',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: order.orderItems.length,
                                    itemBuilder: (context, int index) {
                                      return Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: Container(
                                                      height: 60,
                                                      width: 70,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          imageUrl: order
                                                              .orderItems[index]
                                                              .image,
                                                          placeholder: (context,
                                                                  url) =>
                                                              CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        order.orderItems[index]
                                                            .productName,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Container(
                                                        child: Text(
                                                          order
                                                                  .orderItems[
                                                                      index]
                                                                  .price
                                                                  .toString() +
                                                              'X ' +
                                                              order
                                                                  .orderItems[
                                                                      index]
                                                                  .quantity
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '\$' +
                                                  (order.orderItems[index]
                                                              .quantity *
                                                          order
                                                              .orderItems[index]
                                                              .price)
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Color(0xff0D2F36),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Total:',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Opacity(
                                              opacity: 0.7,
                                              child: Text(
                                                '\$' +
                                                    order.totalPrice.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      (order.status == AppConfig.pendingStatus)
                          ? PendingOrderButtons(
                              pendingOrder: order, provider: provider)
                          : ActiveOrderButton(
                              orderProvider: provider, order: order)
                    ],
                  ),
                )),
          ),
        ),
      );
    });
  }
}
