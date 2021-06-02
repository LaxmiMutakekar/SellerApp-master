import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/pendingOrder/buttons.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/widgets/orderDetail/orderDetails.dart';
import 'package:Seller_App/widgets/textOverFlow.dart';
import 'package:Seller_App/widgets/timer/sliding_text.dart';
import 'package:Seller_App/widgets/timer/swipe_direction.dart';
import 'package:flutter/material.dart';

class PendingOrderCard extends StatelessWidget {
   PendingOrderCard({
    Key key,
    @required this.pendingOrder,
    @required this.provider,
  }) : super(key: key);

  final Orders pendingOrder;
  final OrderProvider provider;
  PendingOrderDetail orderDetail;
  @override
  Widget build(BuildContext context) {
    orderDetail=PendingOrderDetail(provider,pendingOrder);
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {
                      orderDetail.settingModalBottomSheet(context);
                    },
              child: Cards(
            radius: BorderRadius.circular(16),
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#00000000${pendingOrder.orderId}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(width: getProportionateScreenWidth(100)),
                        Container(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              Text(pendingOrder.timePassedFromPlaced),
                              SizedBox(height: 2),
                              Container(
                                height: 1.3,
                                width: 80,
                                color: Colors.black87,
                              )
                            ],
                          ),
                        )
                      ]),
                  SizedBox(height: 2),
                  Text(
                    '\$' + pendingOrder.totalPrice.toInt().toString(),
                    style: TextStyle(
                        color: Color(0xff55B793),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: getProportionateScreenHeight(3)),
                  OverFlowText(
                    text: pendingOrder.orderItemProducts,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                        height: 0.9,
                        width: getProportionateScreenWidth(289),
                        color: Colors.black),
                  ),
                  Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Orders from',
                              style: TextStyle(fontStyle: FontStyle.italic),
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

                          width: getProportionateScreenWidth(200),
                          child: PendingOrderButtons(
                              pendingOrder: pendingOrder, provider: provider),
                        ),
                      ])
                ],
              ),
            )),
      ),
    );
  }
}

class PendingTimeStamp extends StatefulWidget {
  const PendingTimeStamp({
    Key key,
    @required this.pendingOrder,
  }) : super(key: key);

  final Orders pendingOrder;

  @override
  _PendingTimeStampState createState() => _PendingTimeStampState();
}

class _PendingTimeStampState extends State<PendingTimeStamp> {
  int passedTime;
  DateTime currentTime;
  _update(int value) {
    _min10Key.currentState.update(passedTime ~/ 10);
    _minKey.currentState.update(passedTime % 10);
  }

  void setTime() {
    setState(() {
      currentTime = DateTime.now();
      passedTime =
          currentTime.difference(widget.pendingOrder.orderPlacedDate).inMinutes;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTime();
  }

  GlobalKey<SwipingTextState> _minKey = GlobalKey<SwipingTextState>();
  GlobalKey<SwipingTextState> _min10Key = GlobalKey<SwipingTextState>();
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SwipingText(
        key: _min10Key,
        defaultValue: passedTime ~/ 10,
        textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        swipeDirection: SwipeDirection.up,
      ),
      SwipingText(
        key: _minKey,
        textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        defaultValue: passedTime % 10,
        swipeDirection: SwipeDirection.up,
      ),
    ]);
  }
}
