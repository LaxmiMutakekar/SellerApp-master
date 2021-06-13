import 'bound_clipper.dart';
import 'swipe_direction.dart';
import 'package:flutter/material.dart';

class SwipingText extends StatefulWidget {
  final int defaultValue;
  final TextStyle textStyle;
  final Color textColor;
  final BoxDecoration decoration;
  final SwipeDirection swipeDirection;
  final EdgeInsets padding;
  final Size size;

  const SwipingText(
      {Key key,
      this.defaultValue,
      this.textStyle,
      this.decoration,
      this.swipeDirection,
      this.padding,
      this.size,
      this.textColor})
      : super(key: key);

  @override
  SwipingTextState createState() => SwipingTextState();
}

class SwipingTextState extends State<SwipingText>
    with TickerProviderStateMixin {
  int _currentValue = 0;
  int _nextValue = 0;
  AnimationController _controller;

  bool _gotData = false;

  Animatable<Offset> _swipeDetails1 = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  );
  Animation<Offset> _swipeAnimation1;

  Animatable<Offset> _swipeDetails2 = Tween<Offset>(
    begin: const Offset(0.0, 0.0),
    end: Offset(0.0, 1.0),
  );
  Animation<Offset> _swipeAnimation2;

  _init() {
    _gotData = false;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _swipeAnimation1 = _controller.drive(_swipeDetails1);
    _swipeAnimation2 = _controller.drive(_swipeDetails2);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }

      if (status == AnimationStatus.dismissed) {
        _currentValue = _nextValue;
      }
    });

    _currentValue = widget.defaultValue;
  }

  update(value) {
    _gotData = true;
    if (_currentValue == null) {
      _currentValue = value;
    } else if (value != _currentValue) {
      _nextValue = value;
      _controller.forward();
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clipMask = Opacity(
      opacity: 0.0,
      child: Text(
        '0',
        style: widget.textStyle,
        textScaleFactor: 1.0,
        textAlign: TextAlign.center,
      ),
    );

    return Container(
      padding: widget.padding,
      alignment: Alignment.center,
      width: widget.size?.width,
      height: widget.size?.height,
      decoration: widget.decoration,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, w) {
          return Stack(
            fit: StackFit.passthrough,
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              _gotData
                  ? FractionalTranslation(
                      translation:
                          (widget.swipeDirection == SwipeDirection.down)
                              ? _swipeAnimation1.value
                              : -_swipeAnimation1.value,
                      child: ClipRect(
                        clipper: BoundClipper(
                          percentage: _swipeAnimation1.value.dy,
                          isUp: true,
                          flipDirection: widget.swipeDirection,
                        ),
                        child: Text(
                          '$_nextValue',
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.0,
                          style: widget.textStyle,
                        ),
                      ),
                    )
                  : SizedBox(),
              FractionalTranslation(
                translation: (widget.swipeDirection == SwipeDirection.down)
                    ? _swipeAnimation2.value
                    : -_swipeAnimation2.value,
                child: ClipRect(
                  clipper: BoundClipper(
                    percentage: _swipeAnimation2.value.dy,
                    isUp: false,
                    flipDirection: widget.swipeDirection,
                  ),
                  child: Text(
                    '$_currentValue',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    style: widget.textStyle,
                  ),
                ),
              ),
              clipMask,
            ],
          );
        },
      ),
    );
  }
}
