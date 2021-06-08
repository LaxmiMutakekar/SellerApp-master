import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/widgets/defaultButton.dart';
import 'package:Seller_App/widgets/rejectionAleart.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PendingOrderButtons extends StatelessWidget {
  const PendingOrderButtons({
    Key key,
    @required this.pendingOrder,
    @required this.provider,
  }) : super(key: key);

  final Orders pendingOrder;
  final OrderProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DefaultButton(
            buttonColor: Colors.grey[200],
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kButtonRadius),
              side: BorderSide(color: Colors.grey, width: 1.1),
            ),
            press: () async {
              showReasonsDialog(context, pendingOrder);
            },
            text: ('Reject'),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Expanded(
          child: DefaultButton(
            text: ('Accept'),
            press: () {
              {
                pendingOrder.orderPre = DateTime.now();
                provider.acceptOrder(pendingOrder);
                provider.updateAcceptTimings(pendingOrder, DateTime.now());
                APIServices.changeOrderStatus(
                    pendingOrder, AppConfig.preparingStatus);
                showInSnackBar('Order accepted successfully!!', context);

              }
            },
          ),
        ),
      ],
    );
  }
}
