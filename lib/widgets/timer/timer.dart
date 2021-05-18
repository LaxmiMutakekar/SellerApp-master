import 'dart:async';

import 'sliding_text.dart';
import 'swipe_direction.dart';
import 'package:flutter/material.dart';

class TimerBoxSize {
  final Size uniformBoxSize;
  Size hourBoxSize;
  Size minuteBoxSize;
  Size secondBoxSize;

  TimerBoxSize({
    this.uniformBoxSize,
    this.hourBoxSize,
    this.minuteBoxSize,
    this.secondBoxSize,
  }) {
    if (uniformBoxSize != null) {
      this.hourBoxSize = uniformBoxSize;
      this.minuteBoxSize = uniformBoxSize;
      this.secondBoxSize = uniformBoxSize;
    }
  }
}

class TimerBoxPadding {
  final EdgeInsets uniformBoxPadding;
  EdgeInsets hourBoxPadding;
  EdgeInsets minuteBoxPadding;
  EdgeInsets secondBoxPadding;

  TimerBoxPadding({
    this.uniformBoxPadding,
    this.hourBoxPadding,
    this.minuteBoxPadding,
    this.secondBoxPadding,
  }) {
    if (uniformBoxPadding != null) {
      this.hourBoxPadding = uniformBoxPadding;
      this.minuteBoxPadding = uniformBoxPadding;
      this.secondBoxPadding = uniformBoxPadding;
    }
  }
}

class TimerSwipeDirection {
  final SwipeDirection uniformSwipeDirection;
  SwipeDirection hourSwipeDirection;
  SwipeDirection minuteSwipeDirection;
  SwipeDirection secondSwipeDirection;

  TimerSwipeDirection({
    this.uniformSwipeDirection,
    this.hourSwipeDirection,
    this.minuteSwipeDirection,
    this.secondSwipeDirection,
  }) {
    if (uniformSwipeDirection != null) {
      this.hourSwipeDirection = uniformSwipeDirection;
      this.minuteSwipeDirection = uniformSwipeDirection;
      this.secondSwipeDirection = uniformSwipeDirection;
    }
  }
}

class TimerBoxDecoration {
  final BoxDecoration uniformDecoration;
  BoxDecoration hourBoxDecoration;
  BoxDecoration minuteBoxDecoration;
  BoxDecoration secondBoxDecoration;

  TimerBoxDecoration({
    this.hourBoxDecoration,
    this.minuteBoxDecoration,
    this.secondBoxDecoration,
    this.uniformDecoration,
  }) {
    if (uniformDecoration != null) {
      this.hourBoxDecoration = uniformDecoration;
      this.minuteBoxDecoration = uniformDecoration;
      this.secondBoxDecoration = uniformDecoration;
    }
  }
}

class TimerTextStyle {
  final TextStyle uniformTextStyle;
  TextStyle hourTextStyle;
  TextStyle minuteTextStyle;
  TextStyle secondTextStyle;

  TimerTextStyle({
    this.uniformTextStyle,
    this.hourTextStyle,
    this.minuteTextStyle,
    this.secondTextStyle,
  }) {
    if (uniformTextStyle != null) {
      this.hourTextStyle = uniformTextStyle;
      this.minuteTextStyle = uniformTextStyle;
      this.secondTextStyle = uniformTextStyle;
    }
  }
}

class DownTimer extends StatefulWidget {
  final Duration duration;
  final TimerBoxSize timerBoxSize;
  final TimerBoxPadding timerBoxPadding;
  final TimerBoxDecoration timerBoxDecoration;
  final TimerTextStyle timerTextStyle;
  final TimerSwipeDirection swipeDirection;
  final Widget separator;
  final Widget hourLabel;
  final Widget minuteLabel;
  final Widget secondLabel;
  final bool showLabels;
  final DownTimerController timerController;
  final VoidCallback onComplete;

  const DownTimer({
    Key key,
    this.duration,
    this.timerController,
    this.onComplete,
    this.timerBoxSize,
    this.timerBoxPadding,
    this.timerBoxDecoration,
    this.timerTextStyle,
    this.separator,
    this.swipeDirection,
    this.hourLabel,
    this.minuteLabel,
    this.secondLabel,
    this.showLabels,
  }) : super(key: key);

  @override
  _DownTimerState createState() => _DownTimerState();
}

class _DownTimerState extends State<DownTimer> {
  int _seconds = 0;
  Timer _timer;

  setTimer(Duration duration) {
    var seconds = duration?.inSeconds;
    _seconds = seconds;
    _update(_seconds);
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      --_seconds;
      _update(_seconds);
      if (_seconds <= 0) {
        timer?.cancel();
        Future.delayed(Duration(milliseconds: 1000), () {
          if (widget.onComplete != null) widget.onComplete();
        });
      }
    });
  }

  _update(int value) {
    _sec10Key.currentState.update(_sec ~/ 10);
    _secKey.currentState.update(_sec % 10);
    _min10Key.currentState.update(_min ~/ 10);
    _minKey.currentState.update(_min % 10);
  }

  @override
  void initState() {
    if (widget.timerController != null) {
      widget.timerController.updateDuration = setTimer;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setTimer(widget.duration);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  GlobalKey<SwipingTextState> _minKey = GlobalKey<SwipingTextState>();
  GlobalKey<SwipingTextState> _min10Key = GlobalKey<SwipingTextState>();
  GlobalKey<SwipingTextState> _secKey = GlobalKey<SwipingTextState>();
  GlobalKey<SwipingTextState> _sec10Key = GlobalKey<SwipingTextState>();

  int get _min => _seconds ~/ 60;

  int get _sec => _seconds % 60;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SwipingText(
                  key: _min10Key,
                  textStyle: widget.timerTextStyle?.minuteTextStyle,
                  padding: widget.timerBoxPadding?.minuteBoxPadding,
                  size: widget.timerBoxSize?.minuteBoxSize,
                  decoration: widget.timerBoxDecoration?.minuteBoxDecoration,
                  defaultValue: _min ~/ 10,
                  swipeDirection: SwipeDirection.up,
                ),
                SwipingText(
                  key: _minKey,
                  textStyle: widget.timerTextStyle?.minuteTextStyle,
                  padding: widget.timerBoxPadding?.minuteBoxPadding,
                  size: widget.timerBoxSize?.minuteBoxSize,
                  decoration: widget.timerBoxDecoration?.minuteBoxDecoration,
                  defaultValue: _min % 10,
                  swipeDirection: SwipeDirection.up,
                ),
              ],
            ),
            (widget.showLabels ?? false)
                ? widget.secondLabel ??
                    Text(
                      "MM",
                      textScaleFactor: 0.8,
                    )
                : SizedBox.shrink(),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.separator ?? Text(":"),
            (widget.showLabels ?? false)
                ? Text(
                    " ",
                    textScaleFactor: 0.8,
                  )
                : SizedBox.shrink(),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SwipingText(
                  key: _sec10Key,
                  defaultValue: _sec ~/ 10,
                  textStyle: widget.timerTextStyle?.secondTextStyle,
                  padding: widget.timerBoxPadding?.secondBoxPadding,
                  size: widget.timerBoxSize?.secondBoxSize,
                  decoration: widget.timerBoxDecoration?.secondBoxDecoration,
                  swipeDirection: SwipeDirection.up,
                ),
                SwipingText(
                  key: _secKey,
                  defaultValue: _sec % 10,
                  textStyle: widget.timerTextStyle?.secondTextStyle,
                  padding: widget.timerBoxPadding?.secondBoxPadding,
                  size: widget.timerBoxSize?.secondBoxSize,
                  decoration: widget.timerBoxDecoration?.secondBoxDecoration,
                  swipeDirection: SwipeDirection.up,
                ),
              ],
            ),
            (widget.showLabels ?? false)
                ? widget.secondLabel ??
                    Text(
                      "SS",
                      textScaleFactor: 0.8,
                    )
                : SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}

class DownTimerController extends ChangeNotifier {
  void Function(Duration duration) updateDuration;

  DownTimerController();
}