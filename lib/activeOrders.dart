import 'package:flutter/material.dart';
import 'APIServices/APIServices.dart';
import 'App_configs/app_configs.dart';
import 'widgets/cards.dart';
import 'models/orders.dart';
import 'widgets/BottomModalBar.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'providers/orderUpdate.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders>
    with SingleTickerProviderStateMixin {
  CountDownController _controller = CountDownController();
  AnimationController controllerOne;
  Animation<Color> animationOne;
  Animation<Color> animationTwo;
  OrderDetail orderItem = new OrderDetail();
  @override
    void initState() {
      // TODO: implement initState
      //
      super.initState();
      controllerOne = AnimationController(
          duration: Duration(milliseconds: 500), vsync: this);
      animationOne = ColorTween(begin: Colors.black38, end: Colors.white24)
          .animate(controllerOne);
      animationTwo = ColorTween(begin: Colors.white24, end: Colors.black38)
          .animate(controllerOne);
      controllerOne.forward();
      controllerOne.addListener(() {
        if (controllerOne.status == AnimationStatus.completed) {
          controllerOne.reverse();
        } else if (controllerOne.status == AnimationStatus.dismissed) {
          controllerOne.forward();
        }
        this.setState(() {});
      });
    }

    @override
    void dispose() {
      super.dispose();
      controllerOne.dispose();
    }
  @override
  Widget build(BuildContext context) {
    String url;
    String networhUrl;
    return Consumer<Update>(builder: (context, Update orders, child) {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: orders.ordersList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Orders active = orders.ordersList[index];
            networhUrl=active.businessUnit;
            switch (active.businessUnit) {
              case 'Sodimac':
                url = 'assets/$networhUrl.png';
                break;
              case 'Tottus':
                url = 'assets/$networhUrl.png';
                break;
              default:
            }
            if (active.status == 'Order Preparing') {
              return GestureDetector(
                onTap: () {
                  orderItem.settingModalBottomSheet(context, active);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Cards(
                    color: Colors.grey[300],
                    radius: BorderRadius.circular(20),
                    margin: EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  clipBehavior: Clip.hardEdge,
                                  width: 100,
                                  height: 60,
                                  child: FittedBox(
                                    child: Image(
                                      image: new AssetImage(url),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(width: 60),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: CircularCountDownTimer(
                                  width: 60.0,
                                  height: 60.0,
                                  duration:
                                      active.orderPreparationTime.toInt() * 60,
                                  fillColor: Colors.amber,
                                  ringColor: Colors.white,
                                  controller: _controller,
                                  backgroundColor: Colors.white54,
                                  strokeWidth: 5.0,
                                  strokeCap: StrokeCap.round,
                                  isTimerTextShown: true,
                                  isReverse: true,
                                  onComplete: () {
                                    APIServices.changeOrderStatus(
                                        active.orderId, AppConfig.timeout);
                                  },
                                  textStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '#00${active.orderId}',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              productName(active.orderItems),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppConfig.hidingText),
                            ),
                            Text(
                              '\$' + active.totalPrice.toInt().toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppConfig.hidingText),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                              height: 2,
                              width: 140,
                              color: AppConfig.hidingText),
                        ),
                        Container(
                          child: Row(
                            children: [
                              RaisedButton(
                                elevation: 4,
                                splashColor: AppConfig.buttonSplash,
                                onPressed: () {
                                  setState(() {});
                                },
                                color: AppConfig.buttonBackgrd,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text("Mark as done",
                                    style: TextStyle(
                                        color: AppConfig.buttonText,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(width: 8),
                              RaisedButton(
                                elevation: 4,
                                splashColor: Colors.red,
                                onPressed: () {},
                                color: AppConfig.buttonBackgrd,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text("Handover",
                                    style: TextStyle(
                                        color: AppConfig.buttonText,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          });
    });
  }
}
