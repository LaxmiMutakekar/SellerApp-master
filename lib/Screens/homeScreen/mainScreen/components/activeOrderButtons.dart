import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/countDownTimer.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/updateETC.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/widgets/defaultAleart.dart';
import 'package:Seller_App/widgets/defaultButton.dart';
import 'package:flutter/material.dart';

import '../../../verifyScreen.dart';

class ActiveOrderButton extends StatelessWidget {
  final OrderProvider orderProvider;
  final Orders order;
  final CountDownTimer countDownTimer;

  ActiveOrderButton({
    Key key,
    this.orderProvider,
    this.order,
    this.countDownTimer,
  }) : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (order.status != AppConfig.readyStatus)
            ? Expanded(
          child: DefaultButton(
            press: () {
              APIServices.changeOrderStatus(order, AppConfig.readyStatus).then((
                  success) {
                if (success) {
                  orderProvider.activeOrdersUpdate(
                      order, AppConfig.readyStatus);
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Not able to update, error in server")));
                }
              });
            },
            text: ('Mark ready'),
          ),
        )
            : Container(),
        (order.status == AppConfig.preparingStatus)
            ? SizedBox(
          width: getProportionateScreenWidth(8),
        )
            : Container(),
        (order.orderUpdateEtc && order.status == AppConfig.preparingStatus)
            ? Expanded(
          child: DefaultButton(
              press: () {
                updateETC(context).then((res) {
                  if (res is int) {
                    countDownTimer.updateEtcTime = res.toDouble();
                  }
                });
              },
              text: ('Update ETC')),
        )
            : Container(),
        (order.deliveryResource.driverName != null)
            ? SizedBox(
          width: 10,
        )
            : Container(),
        (order.deliveryResource.driverName != null &&
            order.status == AppConfig.readyStatus)
            ? Expanded(
          child: DefaultButton(
            press: () {
              if (order.status != AppConfig.readyStatus) {
                showAleartDialog(
                  context,
                  'Warning!',
                  Text(
                    'You need to first mark your order as ready to proceed with handover',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                );
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Verify(
                              order: order,
                            )));
              }
            },
            text: ('Handover'),
          ),
        )
            : Container()
      ],
    );
  }

  DefaultButton markReadyButton(BuildContext context) {
    return DefaultButton(
      press: () {
        APIServices.changeOrderStatus(order, AppConfig.readyStatus).then((
            success) {
          if (success) {
            orderProvider.activeOrdersUpdate(order, AppConfig.readyStatus);
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Not able to update, error in server")));
          }
        });
      },
      text: ('Mark ready'),
    );
  }
}
