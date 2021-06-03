import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/activeOrderButtons.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/countDownTimer.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/pendingOrder/buttons.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/widgets/upCounter.dart';
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
            constraints: BoxConstraints(maxHeight: 350,minHeight: 200),
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
            constraints: BoxConstraints(minHeight: 200,maxHeight: 350),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
           ActiveOrderButton(
                    orderProvider: provider,
                    order: order,
                  ),
        ],
      ),
    );
  }
}
