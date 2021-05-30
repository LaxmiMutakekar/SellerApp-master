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
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:flutter_svg/svg.dart';

class PendingOrders extends StatefulWidget {
  final OrderProvider orderProvider;
  PendingOrders({
    Key key,
    this.orderProvider,
  }) : super(
          key: key,
        );
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  OrderDetail orderItem = new OrderDetail();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    OrderProvider provider = widget.orderProvider;
    List<Orders> pendingOrder = provider.pendingOrderList;
    if (pendingOrder.isEmpty) {
      return Container(
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              child: SvgPicture.asset(
                                    'assets/Images/sad_panda.svg',
                                    color: Colors.black45,
                                  ),
            ),
            Text(AppConfig.noPendingOrders,style: TextStyle(color: Colors.black45),)
          ],
        ),
      );
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
                    child: PendingOrderCard(
                        pendingOrder: pendings, provider: provider),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class PendingOrderCard extends StatelessWidget {
  const PendingOrderCard({
    Key key,
    @required this.pendingOrder,
    @required this.provider,
  }) : super(key: key);

  final Orders pendingOrder;
  final OrderProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
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
                    mainAxisSize: MainAxisSize.min,
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
                            Text(
                              pendingOrder.timePassedFromPlaced,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w200),
                            ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      FlatButton(
                          minWidth: 100,
                          color: Colors.grey.shade200,
                          //padding: EdgeInsets.symmetric(vertical:16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey, width: 1.1),
                          ),
                          onPressed: () async {
                            showReasonsDialog(context, pendingOrder);
                          },
                          child: Text('Reject')),
                      SizedBox(width: 10),
                      DefaultButton(
                        text: ('Accept'),
                        press: () {
                          {
                            provider.acceptOrder(pendingOrder);
                            provider.updateAcceptTimings(
                                pendingOrder, DateTime.now());
                            APIServices.changeOrderStatus(
                                pendingOrder, AppConfig.preparingStatus);
                            showInSnackBar(
                                'Order accepted succesfully!!', context);
                            pendingOrder.orderPre = DateTime.now();
                          }
                        },
                      ),
                    ])
              ],
            ),
          )),
    );
  }
}
