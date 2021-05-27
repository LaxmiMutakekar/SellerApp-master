import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/widgets/defaultButton.dart';
import 'package:Seller_App/widgets/rejectionAleart.dart';
import 'package:Seller_App/widgets/textOverFlow.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/widgets/orderDetails.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:Seller_App/providers/orderUpdate.dart';

class PendingOrders extends StatefulWidget {
  final Update orderProvider;
  PendingOrders({
    Key key,
     this.orderProvider,
  }) : super(key: key,);
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  OrderDetail orderItem = new OrderDetail();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Update provider=widget.orderProvider;
    List<Orders> pendingOrder=provider.pendingOrders;
      if(provider.pendingOrders.isEmpty)
      {
        return TextContainer(text: AppConfig.noPendingOrders,);
      }
      return SizedBox(
        height: 222,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Pending Orders',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pendingOrder.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Orders pendings = pendingOrder[index];
                    return GestureDetector(
                      onTap: () {
                        orderItem.settingModalBottomSheet(context, pendings);
                      },
                      child: Cards(
                        radius: BorderRadius.circular(20),
                        margin: EdgeInsets.all(3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      width: 70,
                                      height: 40,
                                      child: FittedBox(
                                        child: Image(
                                          image: new AssetImage(pendings.businessLogo),
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      '#00${pendings.orderId}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                     SizedBox(height:getProportionateScreenHeight(8)),
                                  ],
                                ),
                                SizedBox(
                                    width: getProportionateScreenWidth(70.0)),
                                Column(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.schedule_sharp,
                                        size: 34,
                                      ),
                                    ),
                                    Text(
                                      'Placed at',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    Text(
                                      pendings.placedTime,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                OverFlowText(text: pendings.orderItemProducts),
                                Text(
                                  ' \$' + pendings.totalPrice.toInt().toString(),
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Container(
                                  height: 2,
                                  width: 235,
                                  color: Theme.of(context).dividerColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FlatButton(
                                      minWidth: 100,
                                      color: Colors.grey.shade200,
                                      //padding: EdgeInsets.symmetric(vertical:16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                            color: Colors.grey, width: 1.1),
                                      ),
                                      onPressed: () async {
                                        showReasonsDialog(
                                            context, pendings);
                                      },
                                      child: Text('Reject')),
                                  SizedBox(width: 10),
                                  DefaultButton(
                                    text: ('Accept'),
                                    press: () {
                                      {
                                        provider.acceptOrder(pendings);
                                        provider.updateAcceptTimings(
                                            pendings, DateTime.now());
                                        APIServices.changeOrderStatus(
                                            pendings, AppConfig.acceptStatus);
                                        showInSnackBar(
                                            'Order accepted succesfully!!',
                                            context);
                                        pendings.orderPre = DateTime.now();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
  }
}
