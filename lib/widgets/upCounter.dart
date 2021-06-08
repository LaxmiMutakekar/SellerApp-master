import 'dart:async';

import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:Seller_App/widgets/timer/sliding_text.dart';
import 'package:Seller_App/widgets/timer/swipe_direction.dart';
import 'package:flutter/material.dart';

class UpCounter extends StatefulWidget {
  final Orders order;
  UpCounter({
    Key key,
    this.order,
  }) : super(
          key: key,
        );
  @override
  _UpCounterState createState() => _UpCounterState();
}

class _UpCounterState extends State<UpCounter> {
 
  Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  _update(int value) {
    _sec10Key.currentState.update(seconds ~/ 10);
    _secKey.currentState.update(seconds % 10);
    _min10Key.currentState.update(minutes ~/ 10);
    _minKey.currentState.update(minutes % 10);
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _update(seconds);
          if (seconds < 0) {
            _update(0);
            timer.cancel();
          } else {
            _update(seconds);
            seconds = seconds + 1;
            if (seconds > 59) {
              minutes += 1;
              seconds = 0;
              if (minutes > 59) {
                hours += 1;
                minutes = 0;
              }
            }
          }
        },
      ),
    );
  }
 GlobalKey<SwipingTextState> _secKey = GlobalKey<SwipingTextState>();
  GlobalKey<SwipingTextState> _sec10Key = GlobalKey<SwipingTextState>();
  GlobalKey<SwipingTextState> _minKey = GlobalKey<SwipingTextState>();
  GlobalKey<SwipingTextState> _min10Key = GlobalKey<SwipingTextState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      seconds=widget.order.getDelayedSec??0;
      minutes=seconds~/60;
      seconds=seconds%60;
    });
       print(widget.order.getDelayedSec);
    //seconds=widget.order.orderStatusHistory.orderTimeout
    startTimer();
  }
@override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwipingText(
                key: _min10Key,
                defaultValue: minutes ~/ 10,
                textStyle: TextStyle(
                    color: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
                swipeDirection: SwipeDirection.up,
              ),
              SwipingText(
                key: _minKey,
                textStyle: TextStyle(
                    color: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
                defaultValue: minutes % 10,
                swipeDirection: SwipeDirection.up,
              ),
              Text(
                ':',
                style: TextStyle(
                    color: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SwipingText(
                key: _sec10Key,
                textStyle: TextStyle(
                    color: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
                defaultValue: seconds ~/ 10,
                swipeDirection: SwipeDirection.up,
              ),
              SwipingText(
                key: _secKey,
                textStyle: TextStyle(
                    color: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
                defaultValue: seconds %10,
                swipeDirection: SwipeDirection.up,
              ),
            ],
          ),
        ),
        Text('Delayed by')
      ],
    );
  }
}
