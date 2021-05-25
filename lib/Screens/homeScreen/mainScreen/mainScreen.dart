import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/notificationDrawer.dart';
import 'package:Seller_App/Screens/splashScreen.dart';
import 'package:Seller_App/providers/notification.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:Seller_App/widgets/switchButton.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../notifyCount.dart';
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
  Animation<Color> animationOne;
  Animation<Color> animationTwo;

  @override
  void initState() {
    super.initState();
     Provider.of<Update>(context, listen: false).ordersAdded();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final message= Provider.of<Messages>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;
    return Consumer2<Update, SellerDetail>(
                    builder: (context, Update orders, seller, child) {
                      bool status=seller.seller.available;
                      
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isDrawerOpen ? 0.4 * screenwidth : 0,
      right: isDrawerOpen ? -0.2 * screenwidth : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SafeArea(
          child: Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: isDrawerOpen
                ? BorderRadius.circular(40)
                : BorderRadius.circular(0),
            child: Scaffold(
              endDrawer: NotificationDrawer(screenwidth: screenwidth),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                title: 
         Center(
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
                                (seller.seller.name == null)
                                    ? ('Loading..')
                                    : seller.seller.name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              DefaultSwitch(
                                value: seller.seller.available,
                                type: ('Seller'),
                              )
                            ],
                          ),
                          Builder(
                              builder: (context) => Stack(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.notifications_active,
                                            size: 25,color: Colors.black54,),
                                        onPressed: () {
                                          Scaffold.of(context)
                                            .openEndDrawer();
                                            message.messageRead();
                                        }
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: PlayButton())
                                    ],
                                  ))
                          // Container(
                          //   width: getProportionateScreenWidth(60),
                          //   height: getProportionateScreenWidth(60),
                          //   child:
                          // )
                        ]),
                  ),
              
                actions: [
                  Text(''),
                ],
              ),
              body: 
               Builder(
                              builder: (context)
                              {
                                  if(seller.seller.available==null)
                {
                  return Splash();
                }
                if (orders.pendingOrders.isEmpty &&
                    orders.activeOrders.isEmpty) {
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
                            SizedBox(height: 220, child: PendingOrders()),
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
              }
                    ),
                
                ),
            ),
          ),
        ),
      );
                    });
  }
}


class PlayButton extends StatefulWidget {
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
   return Consumer<Messages>(builder: (context, Messages msg, child) {
      if(msg.messagesList.length==0||msg.isRead)
      {
        return Container();
      }
      return AvatarGlow(
        startDelay: Duration(milliseconds: 1000),
        glowColor: Colors.red,
        endRadius: 20.0,
        duration: Duration(milliseconds: 2000),
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: Container(
          height: 16,
          width: 16,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            msg.unreadCount.toString(),
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
