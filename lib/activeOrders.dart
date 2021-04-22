import 'package:flutter/material.dart';
import 'package:order_listing/App_configs/app_configs.dart';
import 'widgets/cards.dart';
import 'package:order_listing/models/orders.dart';
import 'widgets/BottomModalBar.dart';
import 'package:order_listing/widgets/LoadingAnimation.dart';
import 'widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'providers/orderUpdate.dart';
class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  
  OrderDetail orderItem = new OrderDetail();
  @override
  Widget build(BuildContext context) {
    String url;
    
    return  Consumer<Update>(builder: (context, Update orders, child) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: orders.ordersList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Orders active = orders.ordersList[index];
                  switch (active.businessUnit) {
                    case 'Sodimac':
                      url = 'assets/sodi.png';
                      break;
                    case 'Tottus':
                      url = 'assets/tottus.png';
                      break;
                    default:
                  }
                  if(active.status=='Order Preparing')
                  {
                  return GestureDetector(
                    onTap: () {
                      orderItem.settingModalBottomSheet(context, active);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:2.0),
                      child: Cards(
                        color: Colors.grey[300],
                        radius: BorderRadius.circular(20),
                        margin: EdgeInsets.all(3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                                  SizedBox(
                                    width:60
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.schedule_sharp,
                                          size: 34,
                                        ),
                                      ),
                                      Text(
                                            active.orderPlacedDate.hour.toString() +
                                                ":" +
                                                active.orderPlacedDate.minute.toString()+((active.orderPlacedDate.hour)<12?' A.M':' P.M'),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                    ],
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
                                Text(productName(active.orderItems),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: AppConfig.hidingText),),
                                Text('\$'+active.totalPrice.toInt().toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: AppConfig.hidingText),)
                              ],
                            ),
                            
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Container(height:2,width:140,color:AppConfig.hidingText),
              ),
             Container(
               child:Row(
                                children: [
                                  RaisedButton(
                                    elevation: 4,

                                    splashColor: AppConfig.buttonSplash,
                  
                                    onPressed: () {
                                      setState(() {});

                                    },
                                    color: AppConfig.buttonBackgrd,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text("Accept",
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text("Reject",
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
                }else{
                  return Container();
                }
                }
                );
          });
  }
}

