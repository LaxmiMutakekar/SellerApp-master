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
import 'orderItemList.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({this.order, this.provider});

  final Orders order;
  final OrderProvider provider;
  CountDownTimer countDown;
  final ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<OrderProvider>(
        builder: (context, OrderProvider provider, child) {
      countDown = CountDownTimer((provider), order);
      return Hero(
        tag: order.orderId,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            child: SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '#00000000' + order.orderId.toString(),
                          style: textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ColoredBadge(
                                  text: order.status,
                                  color: AppConfig.getColor[order.status],
                                ),
                                (order.status == AppConfig.preparingStatus)
                                    ? countDown.countDownTimer
                                    : (order.status == AppConfig.delayedStatus)
                                        ? UpCounter(order: order)
                                        : Container(),
                              ])),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 360, minHeight: 360),
                        child: RawScrollbar(
                          thumbColor: Colors.black45,
                          isAlwaysShown: true,
                          controller: _scrollController,
                          thickness: 6,
                          //isAlwaysShown: true,
                          radius: Radius.circular(10),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.grey[300],
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    order.customer.name,
                                                    style: textTheme.subtitle2
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  // Opacity(
                                                  //     opacity: 0.7,
                                                  //     child: Icon(
                                                  //       Icons.edit,
                                                  //       size: 17,
                                                  //     )),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.timer),
                                                  Opacity(
                                                    opacity: 0.6,
                                                    child: Text(
                                                      'Received ' +
                                                          order.placedAgo,
                                                      style: textTheme.bodyText1
                                                          .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Opacity(
                                                opacity: 0.6,
                                                child: Text(
                                                  order.expectedByTime
                                                      .toString(),
                                                  style: textTheme.subtitle2
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                              Opacity(
                                                opacity: 0.75,
                                                child: Text(
                                                  'Expected by',
                                                  style: textTheme.bodyText1
                                                      .copyWith(fontSize: 12),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                (order.deliveryResource.driverName != null)
                                    ? Container(
                                        margin: EdgeInsets.all(20),
                                        padding: EdgeInsets.all(5),
                                        child: Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      //mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('Delivered By',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle2
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                        Text(
                                                          order.deliveryResource
                                                              .driverName,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Vehicle Number',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                      ),
                                                      Text(
                                                        order.deliveryResource
                                                            .vehicleNumber,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        ]))
                                    : Container(),
                                OrderItemList(
                                  order: order,
                                ),
                                Container(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Total Amount:',
                                            style: textTheme.subtitle2),
                                        Text(
                                          order.totalPrice.toString() + '\$',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: (order.status == AppConfig.pendingStatus)
                            ? PendingOrderButtons(
                                pendingOrder: order,
                                provider: provider,
                              )
                            : ActiveOrderButton(
                                order: order,
                                orderProvider: provider,
                              ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      );
    });
  }
}
