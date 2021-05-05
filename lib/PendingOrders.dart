import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'App_configs/app_configs.dart';
import 'widgets/cards.dart';
import 'models/orders.dart';
import 'widgets/orderDetails.dart';
import 'APIServices/APIServices.dart';
import 'widgets/widgets.dart';
import 'models/rejectionReasons.dart';
import 'package:provider/provider.dart';
import 'providers/orderUpdate.dart';
import 'package:intl/intl.dart';
import 'widgets/rejectionAleart.dart';
class PendingOrders extends StatefulWidget {
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  OrderDetail orderItem = new OrderDetail();
  DateTime orderplacedTime;
  String time;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String url;
    String networkUrl;
    return Consumer<Update>(builder: (context, Update orders, child) {
      return Column(
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
                itemCount: orders.pendingOrders.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Orders pendings = orders.pendingOrders[index];
                  orderplacedTime = pendings.orderPlacedDate;
                  time = DateFormat.jm().format(orderplacedTime);
                  networkUrl = pendings.businessUnit;
                  switch (pendings.businessUnit) {
                    case 'Sodimac':
                      url = 'assets/$networkUrl.png';
                      break;
                    case 'Tottus':
                      url = 'assets/$networkUrl.png';
                      break;
                    default:
                  }
                  return GestureDetector(
                    onTap: () {
                      orderItem.settingModalBottomSheet(
                          context, pendings, index);
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
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 70,
                                  height: 40,
                                  child: FittedBox(
                                    child: Image(
                                      image: new AssetImage(url),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(width: 40),
                              Column(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.schedule_sharp,
                                      size: 34,
                                    ),
                                  ),
                                  Text(
                                    time,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Text(
                                    'Order placed time',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Text(
                            '#00${pendings.orderId}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Row(
                            children: [
                              Text(
                                productName(pendings.orderItems),
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                '\$' + pendings.totalPrice.toInt().toString(),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      orders.acceptOrder(index);
                                      APIServices.changeOrderStatus(
                                          pendings.orderId,
                                          AppConfig.acceptStatus);
                                      showInSnackBar(
                                          'Order accepted succesfully!!',
                                          context);
                                    },
                                    child: Text(
                                      'Accept',
                                      style: Theme.of(context).textTheme.button,
                                    )),
                                SizedBox(width: 10),
                                ElevatedButton(
                                    onPressed: ()async {
                                      showReasonsDialog(context,index,pendings.orderId);
                                    },
                                    child: Text('Reject',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button)),
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
      );
    });
  }
  

}
