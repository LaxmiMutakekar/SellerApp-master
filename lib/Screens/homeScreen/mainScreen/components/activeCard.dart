import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/activeOrderButtons.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/widgets/coloredBadge.dart';
import 'package:Seller_App/widgets/orderDetail/orderDetails.dart';
import 'package:Seller_App/widgets/textOverFlow.dart';
import 'package:Seller_App/widgets/timer/timer.dart';
import 'package:Seller_App/widgets/upCounter.dart';
import 'package:flutter/material.dart';

import 'countDownTimer.dart';
OrderDetail orderDetail;

class ActiveOrderCard extends StatefulWidget {
  ActiveOrderCard({
    Key key,
    this.orderProvider,
    this.activeOrder,
  }) : super(key: key);
  OrderProvider orderProvider;
  Orders activeOrder;

  @override
  _ActiveOrderCardState createState() => _ActiveOrderCardState();
}

class _ActiveOrderCardState extends State<ActiveOrderCard> {

  
  CountDownTimer _countDownTimer;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countDownTimer=CountDownTimer( widget.orderProvider,widget.activeOrder);
   
  }
  @override
  Widget build(BuildContext context) {
     
    return GestureDetector(
      onTap: () {
        orderDetail=OrderDetail(widget.orderProvider,widget.activeOrder);
        orderDetail.setTimer=_countDownTimer;
        orderDetail.settingModalBottomSheet(context);
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
                              '#00000000${widget.activeOrder.orderId}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              '\$' + widget.activeOrder.totalPrice.toInt().toString(),
                              style: TextStyle(
                                  color: Color(0xff55B793),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Spacer(),
                        ColoredBadge(
                          text: widget.activeOrder.status,
                          color:AppConfig.getColor[widget.activeOrder.status],
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OverFlowText(
                        text: widget.activeOrder.orderItemProducts,
                      ),
                      (widget.activeOrder.status==AppConfig.preparingStatus)
                          ? Column(
                            children: [
                              Container(
                                  
                                  child:_countDownTimer.countDownTimer,
                                ),
                                Text('MM : SS'),
                            ],
                          )
                          : (widget.activeOrder.status==AppConfig.delayedStatus)?
                          UpCounter(order: widget.activeOrder,):Container()
                    ],
                  ),
                  ActiveOrderButton( orderProvider: widget.orderProvider,order: widget.activeOrder,countDownTimer: _countDownTimer,),
                ],
              ),
            )),
      ),
    );
  }

  
}