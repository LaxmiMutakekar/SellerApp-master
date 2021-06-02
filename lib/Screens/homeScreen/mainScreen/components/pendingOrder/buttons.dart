import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
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
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
                  child: FlatButton(
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
        ),
             SizedBox(width: 10),
    Expanded(
          child: DefaultButton(
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
    ),
      ],
    );
  }
}