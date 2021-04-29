import 'package:flutter/material.dart';
import 'APIServices/APIServices.dart';
import 'App_configs/app_configs.dart';
import 'widgets/cards.dart';
import 'models/orders.dart';
import 'widgets/BottomModalBar.dart';
import 'widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'providers/orderUpdate.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders>
    with SingleTickerProviderStateMixin {
  // CountDownController _controller = CountDownController();
  AnimationController controllerOne;
  Animation<Color> animationOne;
  Animation<Color> animationTwo;
  OrderDetail orderItem = new OrderDetail();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   //
  //   super.initState();
  //   controllerOne =
  //       AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  //   animationOne = ColorTween(begin: Colors.black38, end: Colors.white24)
  //       .animate(controllerOne);
  //   animationTwo = ColorTween(begin: Colors.white24, end: Colors.black38)
  //       .animate(controllerOne);
  //   controllerOne.forward();
  //   controllerOne.addListener(() {
  //     if (controllerOne.status == AnimationStatus.completed) {
  //       controllerOne.reverse();
  //     } else if (controllerOne.status == AnimationStatus.dismissed) {
  //       controllerOne.forward();
  //     }
  //     this.setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controllerOne.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    String chosenValue='All accepted orders';
    String url;
    String networhUrl;
    return Consumer<Update>(builder: (context, Update orders, child) {
      chosenValue = orders.chosenValue;
      if(orders.activeOrders.isEmpty)
      {
        return Container();
      }
      return Column(
          children: [
            Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 14.0, right: 8),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Active Orders',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
              
                              DropdownButton<String>(
                                value: chosenValue,
                                underline: Container(
                                  height: 2,
                                  color: Colors.black45,
                                ),
                                elevation: 10,
                                style: TextStyle(color: Colors.black),

                                items: <String>[
                                  'All accepted orders',
                                  'Order Preparing',
                                  'Order Ready',
                                  'Order Timeout',
                                ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Sort the orders",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    chosenValue = value;
                                    //print(chosenValue);
                                  });
                                  
                                  Provider.of<Update>(context,
                                          listen: false)
                                      .sort(chosenValue);
                                },
                                //value:_chosenValue;
                              ),
                            ],
                          ),
                        )),
                  ),
            ContainerCard(
                child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: orders.activeOrders.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Orders active = orders.activeOrders[index];
              networhUrl = active.businessUnit;
              switch (active.businessUnit) {
                case 'Sodimac':
                url = 'assets/$networhUrl.png';
                break;
                case 'Tottus':
                url = 'assets/$networhUrl.png';
                break;
                default:
              }
              if (orders.chosenValue == 'All accepted orders') {
                
                return activeOrders(active, url, orders, index);
                
              } else {
                if (active.status == orders.chosenValue) {
                return activeOrders(active, url, orders, index);
                } else {
                return Container();
                }
              }
            }),
            ),
          ],
        );
    });
  }

  activeOrders(Orders active, url, orders, index) {
    return GestureDetector(
      onTap: () {
        orderItem.settingModalBottomSheet(context, active, index);
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
              //       Container(
              //           padding: EdgeInsets.all(8),
              //           child: active.status == 'Order Preparing'
              //               ? CircularCountDownTimer(
              //                   width: 60.0,
              //                   height: 60.0,
              //                   duration: active.orderPreparationTime.toInt()*60,
              //                   fillColor:
              //                       done ? Colors.green[800] : Colors.red[700],
              //                   ringColor: Colors.white,
              //                   controller: _controller,
              //                   backgroundColor: Colors.white54,
              //                   strokeWidth: 2.0,
              //                   strokeCap: StrokeCap.round,
              //                   isTimerTextShown: true,
              //                   isReverse: true,
              //                   onComplete: () {
              //                     setState(() {
                                    
              //                       done = true;
              //                     });
              //                     orders.updateOrderStatus(
              //                           AppConfig.timeout, index);
              //                     APIServices.changeOrderStatus(
              //                         active.orderId, AppConfig.timeout);
              //                   },
              //                   textFormat: CountdownTextFormat.MM_SS,
              //                   textStyle: TextStyle(
              //                       fontSize: 15.0, color: Colors.black),
              //                 )
              //               : Container()),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#00${active.orderId}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                        //width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: active.status == 'Order Ready'
                              ? AppConfig.readyColor
                              : active.status == 'Order Complete'
                                  ? AppConfig.completedColor
                                  : AppConfig.preparingColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            active.status,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ],
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
                    height: 2, width: 140, color: AppConfig.hidingText),
              ),
              Container(
                child: Row(
                  children: [
                    active.status == 'Order Preparing'
                        ? RaisedButton(
                            elevation: 4,
                            splashColor: AppConfig.buttonSplash,
                            onPressed: () {
                              setState(() {
                                orders.activeOrdersUpdate(
                                    index,AppConfig.markAsDone);
                                APIServices.changeOrderStatus(
                                    active.orderId, AppConfig.markAsDone);
                              });
                            },
                            color: AppConfig.buttonBackgrd,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("Mark as done",
                                style: TextStyle(
                                    color: AppConfig.buttonText,
                                    fontWeight: FontWeight.bold)),
                          )
                        : SizedBox(width: 0),
                    SizedBox(width: 8),
                    active.status != 'Order Complete'
                        ? RaisedButton(
                            elevation: 4,
                            splashColor: Colors.red,
                            onPressed: () {},
                            color: AppConfig.buttonBackgrd,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("update ETC",
                                style: TextStyle(
                                    color: AppConfig.buttonText,
                                    fontWeight: FontWeight.bold)),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
