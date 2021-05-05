import 'package:Seller_App/pendingOrders.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pendingOrders.dart';
import 'package:Seller_App/activeOrders.dart';
import '../providers/orderUpdate.dart';
import '../widgets/widgets.dart';
import '../App_configs/app_configs.dart';

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

            appBar: AppBar(

              automaticallyImplyLeading: false,
              elevation: 0,
              title: Consumer2<Update,SellerDetail>(builder: (context, Update orders, seller ,child) {
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
                            (seller.seller.name==null)?('Loading..'):seller.seller.name,
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
            body: Consumer2<Update,SellerDetail>(builder: (context, Update orders, seller ,child) {
              bool status = seller.seller.available??true;
              if (orders.pendingOrders.isEmpty && orders.activeOrders.isEmpty) {
                return currentlyNoOrders(context);
              } else {
                if (status) {
                  if (orders.pendingOrders.isEmpty &&
                      orders.activeOrders.isNotEmpty) {
                    return SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            noPendingOrders(),
                            ActiveOrders(),
                          ],
                        ));
                  }
                  return SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 234, child: PendingOrders()),
                          ActiveOrders(),
                        ],
                      ));
                } else {
                  if (orders.activeOrders.isNotEmpty) {
                    return SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            errorBox(),
                            ActiveOrders(),
                          ],
                        ));
                  }
                  return errorBox();
                }
              }
            }),
          ),
        ),
      ),
    );
  }
}
