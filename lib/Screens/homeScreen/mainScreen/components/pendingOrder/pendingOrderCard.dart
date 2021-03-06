import 'dart:async';

import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/pendingOrder/buttons.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/utilities/pageRoute.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/widgets/orderDetail/orderDetails.dart';
import 'package:Seller_App/widgets/textOverFlow.dart';
import 'package:Seller_App/widgets/timer/sliding_text.dart';
import 'package:Seller_App/widgets/timer/swipe_direction.dart';
import 'package:flutter/material.dart';

class PendingOrderCard extends StatefulWidget {
  PendingOrderCard({
    Key key,
    @required this.pendingOrder,
    @required this.provider,
  }) : super(key: key);

  final Orders pendingOrder;
  final OrderProvider provider;

  @override
  _PendingOrderCardState createState() => _PendingOrderCardState();
}

class _PendingOrderCardState extends State<PendingOrderCard> {
  Timer _timer;
  String minAfterPlaced = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    minAfterPlaced = widget.pendingOrder.placedAgo;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneMin = const Duration(minutes: 1);
    _timer = new Timer.periodic(
      oneMin,
      (Timer timer) => setState(
        () {
          minAfterPlaced = widget.pendingOrder.placedAgo;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {
          print(widget.pendingOrder.isCancelled);
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => Center(
                child: DetailScreen(
                  order: widget.pendingOrder,
                  provider: widget.provider,
                ),
              ),
            ),
          );
        },
        child: Hero(
          tag: widget.pendingOrder.orderId,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Cards(
                radius: BorderRadius.circular(16),
                margin: EdgeInsets.all(3),
                padding: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.76,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '#00000000${widget.pendingOrder.orderId}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Opacity(
                                      opacity: 0.6,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Received ' + minAfterPlaced,
                                            style: textTheme.bodyText1.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )),
                                  SizedBox(height: 2),
                                  // Container(
                                  //   height: 1.3,
                                  //   width: getProportionateScreenWidth(80),
                                  //   color: Colors.black87,
                                  // )
                                ],
                              )
                            ]),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '\$' + widget.pendingOrder.totalPrice.toInt().toString(),
                        style: TextStyle(
                            color: Color(0xff55B793),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: getProportionateScreenHeight(3)),
                      OverFlowText(
                        width: 300,
                        text: widget.pendingOrder.orderItemProducts,
                      ),
                      Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                      //   child: Container(
                      //       height: 0.9,
                      //       width: getProportionateScreenWidth(200),
                      //       color: Colors.black),
                      // ),
                      Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Opacity(
                                  opacity: 0.6,
                                  child: Text(
                                    'Orders from',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 10),
                                  ),
                                ),
                                Container(
                                    height: 30,
                                    width: 70,
                                    child: Image.asset(
                                      "assets/Images/falabellaLogo.png",
                                    ))
                              ],
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(16),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(210),
                              child: PendingOrderButtons(
                                  pendingOrder: widget.pendingOrder,
                                  provider: widget.provider),
                            ),
                          ])
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

