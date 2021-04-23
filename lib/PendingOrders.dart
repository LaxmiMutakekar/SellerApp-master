import 'package:flutter/material.dart';
import 'package:order_listing/App_configs/app_configs.dart';
import 'package:order_listing/providers/rejection.dart';
import 'widgets/cards.dart';
import 'package:order_listing/models/orders.dart';
import 'widgets/BottomModalBar.dart';
import 'package:order_listing/widgets/LoadingAnimation.dart';
import 'APIServices/APIServices.dart';
import 'widgets/widgets.dart';
import 'models/rejectionReasons.dart';
import 'package:provider/provider.dart';
import 'package:order_listing/models/rejectionReasons.dart';
import 'providers/orderUpdate.dart';

class PendingOrders extends StatefulWidget {
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  OrderDetail orderItem = new OrderDetail();

  @override
  Widget build(BuildContext context) {
    String url;
    return Consumer<Update>(builder: (context, Update orders, child) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: orders.ordersList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Orders pendings = orders.ordersList[index];
            switch (pendings.businessUnit) {
              case 'Sodimac':
                url = 'assets/sodi.png';
                break;
              case 'Tottus':
                url = 'assets/tottus.png';
                break;
              default:
            }
            if (pendings.status == "Order Placed") {
              return GestureDetector(
                onTap: () {
                  orderItem.settingModalBottomSheet(context, pendings);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Cards(
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
                              SizedBox(width: 60),
                              Column(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.schedule_sharp,
                                      size: 34,
                                    ),
                                  ),
                                  Text(
                                    pendings.orderPlacedDate.hour.toString() +
                                        ":" +
                                        pendings.orderPlacedDate.minute
                                            .toString() +
                                        ((pendings.orderPlacedDate.hour) < 12
                                            ? ' A.M'
                                            : ' P.M'),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '#00${pendings.orderId}',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              productName(pendings.orderItems),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppConfig.hidingText),
                            ),
                            Text(
                              '\$' + pendings.totalPrice.toInt().toString(),
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
                                  orders.updateOrderStatus(
                                      AppConfig.acceptStatus, index);
                                  APIServices.changeOrderStatus(
                                      pendings.orderId, AppConfig.acceptStatus);
                                },
                                color: AppConfig.buttonBackgrd,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text("Accept",
                                    style: TextStyle(
                                        color: AppConfig.buttonText,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(width: 8),
                              RaisedButton(
                                elevation: 4,
                                splashColor: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    _showRejectionchoiceDialog(
                                        index, orders, pendings);
                                  });
                                },
                                color: AppConfig.buttonBackgrd,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
            } else {
              return Container();
            }
          });
    });
  }

  _showRejectionchoiceDialog(i, orders, pending) => showDialog(
      context: context,
      builder: (context) {
        final _rejectioneNotifier =
            Provider.of<RejectionReasons>(context, listen: false);
        return Consumer<RejectionReasons>(builder: (context, value, child) {
          return AlertDialog(
            title: Text('Select Rejection Reason'),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: reasons
                      .map((e) => RadioListTile(
                            title: Text(e),
                            value: e,
                            groupValue: _rejectioneNotifier.currentReason,
                            selected: _rejectioneNotifier.currentReason == e,
                            onChanged: (value) {
                              _rejectioneNotifier.updateReason(value);
                              // Navigator.of(context).pop();
                            },
                          ))
                      .toList(),
                ),
              ),
            ),
            actions: [
              FlatButton(
                  child: Text('Continue'),
                  onPressed: () {
                    setState(() {});
                    orders.updateOrderStatus(AppConfig.rejectedStatus, i);
                    APIServices.changeOrderStatus(
                        pending.orderId, AppConfig.rejectedStatus);
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  }),
            ],
          );
        });
      });
}
