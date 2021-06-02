import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/activeOrderButtons.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/countDownTimer.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/pendingOrder/buttons.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Seller_App/models/orders.dart';

import '../coloredBadge.dart';
import '../upCounter.dart';
import 'defaultOrderDetail.dart';

class OrderDetail {
  OrderProvider orderProvider;
  Orders order;
  CountDownTimer countDown;
  OrderDetail(this.orderProvider, this.order);
  set setTimer(CountDownTimer timer) {
    countDown = timer;
  }

  @override
  void settingModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: buildBottomSheet(context),
          );
        });
  }

  buildBottomSheet(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ColoredBadge(
                text: order.status,
                color: AppConfig.getColor[order.status],
              ),
            ),
            (order.status == AppConfig.preparingStatus)
                ? countDown.countDownTimer
                : (order.status == AppConfig.delayedStatus)
                    ? UpCounter(
                        order: order,
                      )
                    : Container(),
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
            ActiveOrderButton(
              orderProvider: orderProvider,
              order: order,
            ),
          ],
        ),
      ),
    );
  }
}

class PendingOrderDetail {
  OrderProvider orderProvider;
  Orders order;
  PendingOrderDetail(this.orderProvider, this.order);
  @override
  void settingModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: buildBottomSheet(context),
          );
        });
  }

  buildBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            //color: Color(0xff393E43),
          ),
          DefaultOrderDetail(order: order),
          Container(
              child: PendingOrderButtons(
            provider: orderProvider,
            pendingOrder: order,
          )),
        ],
      ),
    );
  }
}
