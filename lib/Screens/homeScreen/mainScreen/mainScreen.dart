import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/providers/notification.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:Seller_App/widgets/switchButton.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/activeOrders.dart';
import 'components/pendingOrders.dart';
import 'package:avatar_glow/avatar_glow.dart';
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
      appBar: buildAppBar(),
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
                    SizedBox(height: 236, child: PendingOrders()),
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
  AppBar buildAppBar() {
    return AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Consumer2<Update,SellerDetail>(builder: (context, Update orders, seller ,child) {
              return Center(
                child: Row(
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
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                          ),
                          DefaultSwitch(value: seller.seller.available,type: ('Seller'),)
                        ],
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed:(){},
                                
                                  icon:Icon(Icons.notifications_active,size: 25,),
                                  color: AppConfig.iconColor,

                                ),
                            ),
                            Positioned(
                              top: 16,
                              // top: 10,
                              // right: 10,
                              child: PlayButton(),
                                //     child: Container(
                                //       height: 15,
                                //       width: 15,
                                //   decoration: BoxDecoration(
              
                                //     borderRadius: BorderRadius.circular(20),
                                //     color: Colors.red
                                //   ),
                                // ),
                            ),
                            
                          ],
                        ),
                      )
                    ]),
              );
            }),
          );
  }
}
class PlayButton extends StatefulWidget {
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
 
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationCount>(builder: (context, NotificationCount count, child) {
  return AvatarGlow(
    startDelay: Duration(milliseconds: 1000),
    glowColor: Colors.red,
    endRadius: 20.0,
    duration: Duration(milliseconds: 2000),
    showTwoGlows: true,
    repeatPauseDuration: Duration(milliseconds: 100),
    repeat: true,
    child: Container(
      height:16,
      width: 16,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        ),
      child: Text(
        count.count.toString(),
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w800,
          color: Color(0xFF7557D6)),
        ),
      ),
    );
    });
  }
}
