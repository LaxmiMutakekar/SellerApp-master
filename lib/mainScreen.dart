import 'session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'pendingOrders.dart';
import 'activeOrders.dart';
import 'widgets/cards.dart';
import 'providers/orderUpdate.dart';
import 'widgets/widgets.dart';
import 'App_configs/app_configs.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  bool isDrawerOpen = false;
  double screenwidth, screenheight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  AnimationController controllerOne;
  Animation<Color> animationOne;
  Animation<Color> animationTwo;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    controllerOne = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isDrawerOpen ? 0.4 * screenwidth : 0,
      right: isDrawerOpen ? -0.2 * screenwidth : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: isDrawerOpen
              ? BorderRadius.circular(40)
              : BorderRadius.circular(0),
          child: Scaffold(
            backgroundColor: AppConfig.backgroundM,
            appBar: AppBar(
              backgroundColor: AppConfig.backgroundM,
              elevation: 0,
              title: Consumer<Update>(builder: (context, Update orders, child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerOpen
                          ? IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                setState(() {
                                  isDrawerOpen = !isDrawerOpen;
                                  _controller.reverse();
                                });
                              })
                          : IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                setState(() {
                                  isDrawerOpen = !isDrawerOpen;
                                  _controller.forward();
                                });
                              }),
                      Column(
                        children: [
                          Text(
                            orders.sellerName,
                            style: TextStyle(fontSize: 14),
                          ),
                          SwitchButton()
                        ],
                      ),
                      Icon(
                        Icons.notifications_active,
                        color: AppConfig.iconColor,
                      )
                    ]);
              }),
            ),
            body: ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Pending Orders',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Consumer<Update>(
                    builder: (context, Update statusUpdate, child) {
                  bool status = statusUpdate.sellerAvlb;
                  if (status) {
                    return SizedBox(height: 170, child: PendingOrders());
                  } else {
                    return errorBox();
                  }
                }),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Active Orders',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ContainerCard(
                  child: ActiveOrders(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
