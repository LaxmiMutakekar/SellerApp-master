import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/FireBase/firebase_config.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/mainScreen.dart';
import 'package:Seller_App/models/notificationModel.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/providers/notification.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationDrawer extends StatelessWidget {
  NotificationDrawer({
    Key key,
    @required this.screenwidth,
  }) : super(key: key);

  final double screenwidth;
  String orderplacedTime;
  @override
  Widget build(BuildContext context) {
    return Consumer2<Messages,Update>(builder: (context, Messages msg,Update order, child) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
        width: screenwidth * 0.7,
        child: Drawer(
          child: Container(
              child: Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Notifications',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              (msg.messagesList.length==0)?Expanded(child: Center(child: Container(child: Text('No new messages'),))):
              Expanded(
                              child: ListView.builder(
                  itemCount: msg.messagesList.length,
                  itemBuilder: (context, index) {
                    
                    Message message=msg.messagesList[index];
                    int oid=int.parse(message.title);
                    Orders ordermsg=order.ordersList.firstWhere((element) => element.orderId==oid);
                    orderplacedTime=DateFormat.jm().format(ordermsg.orderPlacedDate);
                    print(msg.messagesList.length);
                     
                    return Cards(
                      color: Color(0xffF1F5EF),
                      padding: EdgeInsets.all(0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical:10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        width: 280,
                        height: 87,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                height:getProportionateScreenHeight(42),
                                width: getProportionateScreenWidth(42),
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xff79BB8B)),
                                child: Center(child: Text('#00${message.title}',style: TextStyle(fontSize: 12),)),
                              ),
                              SizedBox(width:getProportionateScreenWidth(5)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Text('You have received a new order !',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),
                                    Row(
                                      children: [
                                        Text('OrderID:',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                        Text('#00${message.title}',style: TextStyle(fontSize: 12),),
                                      ],
                                      
                                    ),
                                    Row(
                                      children: [
                                        Text('Cart Items:',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                        Text(productName(ordermsg.orderItems),style: TextStyle(fontSize: 12),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children:[
                                        SizedBox(width:getProportionateScreenWidth(110)),
                                        Text(orderplacedTime,style:TextStyle(fontSize: 12,fontWeight:FontWeight.bold))
                                      ]
                                    )
                                  ]
                                ),
                              )
                              ],
                            ),
                           
                          ],
                        ),
                      ));
                  },
                ),
              ),
               Row(
                 children: [
                   SizedBox(width:getProportionateScreenWidth(140)),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                        color: Color(0xff9FD951)),
                                        padding: EdgeInsets.all(8),
                         width: getProportionateScreenWidth(100),
                         child: Text('Mark as read',style: TextStyle(fontWeight: FontWeight.bold,))),
                         onTap: (){
                           msg.clearAllmessages();
                         },
                     ),
                   ),
                 ],
               )
            ],
          )),
        ),
      );
    });
  }
}
