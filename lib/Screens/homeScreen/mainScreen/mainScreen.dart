import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/notificationDrawer.dart';
import 'package:Seller_App/Screens/splashScreen.dart';
import 'package:Seller_App/providers/notification.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:Seller_App/widgets/notificationBell.dart';
import 'package:Seller_App/widgets/switchButton.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/activeOrders.dart';
import 'components/pendingOrders.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/mainScreen";
    final Update orderProvider;
  final SellerDetail sellerProvider;
  MainScreen({
    Key key,
     this.orderProvider,
     this.sellerProvider,
  }) : super(key: key,);

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
    widget.sellerProvider.fetchSeller();
    widget.orderProvider.ordersAdded();
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
    bool availablity=widget.sellerProvider.seller.available;
    String sellerName=widget.sellerProvider.seller.name;
    final message = Provider.of<Messages>(context, listen: false);
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
          child: SafeArea(
            child: Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(40)
                  : BorderRadius.circular(0),
              child: Scaffold(
                endDrawer: NotificationDrawer(screenwidth: screenwidth,orderProvider: widget.orderProvider,),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isDrawerOpen
                              ? DefaultIconButton(icon: Icon(Icons.arrow_back),onPress: (){
                                setState(() {
                                      isDrawerOpen = !isDrawerOpen;
                                      _controller.reverse();
                                    });
                                    },)
                              : DefaultIconButton(icon: Icon(Icons.menu),onPress: (){
                                setState(() {
                                      isDrawerOpen = !isDrawerOpen;
                                      _controller.forward();
                                    });
                              },),
                          Column(
                            children: [
                              Text(
                                (sellerName == null)
                                    ? ('Loading..')
                                    : sellerName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              DefaultSwitch(
                                value: availablity,
                                type: ('Seller'),
                                model: widget.sellerProvider,
                              )
                            ],
                          ),
                          Builder(
                              builder: (context) => InkWell(
                                                              child: Stack(
                                      children: [
                                        Icon(
                                              Icons.notifications_active,
                                            ),
                                        PlayButton()
                                      ],
                                    ),
                                    onTap: (){
                                      Scaffold.of(context)
                                                  .openEndDrawer();
                                              message.messageRead();
                                    },
                              ))
                        ]),
                  ),
                  actions: [
                    Text(''),
                  ],
                ),
                body: Builder(builder: (context) {
                  if (availablity == null) {
                    return Splash();
                  }
                  if (availablity) {
                    if (widget.orderProvider.pendingOrders.isEmpty &&
                        widget.orderProvider.activeOrders.isEmpty) {
                          
                      return TextContainer(text: AppConfig.currenlyNoOrder);
                    }
                    return buildSingleChildScrollView(PendingOrders(orderProvider:widget.orderProvider),ActiveOrders(orderProvider: widget.orderProvider,));
                  } else {
                    return buildSingleChildScrollView(TextContainer(text: AppConfig.availableError),ActiveOrders(orderProvider: widget.orderProvider,));
                  }
                }),
              ),
            ),
          ),
        ),
      );

  }
  SingleChildScrollView buildSingleChildScrollView(w1,w2) {
    return SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          w1,
                          w2,
                        ],
                      ));
  }
}
