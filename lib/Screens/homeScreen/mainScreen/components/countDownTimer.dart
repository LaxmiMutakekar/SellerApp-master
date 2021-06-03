import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/widgets/timer/timer.dart';
import 'package:flutter/material.dart';

class CountDownTimer {
  OrderProvider orderProvider;
  Orders order;
  CountDownTimer(this.orderProvider, this.order);
  DownTimerController _timerController = DownTimerController();
  set updateEtcTime(double duration) {
    _timerController.updateDuration(
        Duration(seconds: order.remSeconds + duration.toInt() * 60));
    orderProvider.updateETC(order,duration);
  }

  Container get countDownTimer {
    return Container(
      width: getProportionateScreenWidth(70),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        boxShadow: [
          // to make elevation
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 0),
            blurRadius: 20,
          ),
          // to make the coloured border
        ],
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: DownTimer(
        timerController: _timerController,
        timerTextStyle: TimerTextStyle(
          uniformTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: Duration(seconds: order.remSeconds ?? 0),
        onComplete: () {
          APIServices.changeOrderStatus(order, AppConfig.delayedStatus);
          orderProvider.activeOrdersUpdate(order, AppConfig.delayedStatus);
        },
      ),
    );
  }
}
