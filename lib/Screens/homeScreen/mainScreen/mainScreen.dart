import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/components/notificationDrawer.dart';
import 'package:Seller_App/Screens/splashScreen.dart';
import 'package:Seller_App/providers/notification.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:Seller_App/widgets/notificationBell.dart';
import 'package:Seller_App/widgets/switchButton.dart';
import 'package:Seller_App/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'components/activeOrders.dart';
import 'components/pendingOrder/pendingOrders.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/mainScreen";
  final OrderProvider orderProvider;
  final SellerProvider sellerProvider;

  MainScreen({
    Key key,
    this.orderProvider,
    this.sellerProvider,
  }) : super(
          key: key,
        );

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
    final sellerProvider = widget.sellerProvider;
    final orderProvider = widget.orderProvider;
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
              endDrawer: NotificationDrawer(
                orderProvider: widget.orderProvider,
              ),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: isDrawerOpen
                    ? DefaultIconButton(
                        icon: Icon(Icons.arrow_back),
                        onPress: () {
                          setState(() {
                            isDrawerOpen = !isDrawerOpen;
                            _controller.reverse();
                          });
                        },
                      )
                    : DefaultIconButton(
                        icon: Icon(Icons.menu),
                        onPress: () {
                          setState(() {
                            isDrawerOpen = !isDrawerOpen;
                            _controller.forward();
                          });
                        },
                      ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Master Chief Kitchen ' ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 14),
                    ),
                    Row(
                      children: [
                        DefaultSwitch(
                          value: sellerProvider.seller.available,
                          type: ('Seller'),
                          model: sellerProvider,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          (sellerProvider.seller.available ?? true)
                              ? 'Available'
                              : 'Offline',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  Builder(
                      builder: (context) => InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.notifications_active,
                                  ),
                                  PlayButton()
                                ],
                              ),
                            ),
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                              message.messageRead();
                            },
                          ))
                ],
              ),
              body: Builder(builder: (context) {
                return (sellerProvider.seller.available)
                    //seller available
                    ? (orderProvider.pendingOrderList.isEmpty &&
                            orderProvider.activeOrderList.isEmpty)
                        //orders not available
                        ? Container(
                            child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/Images/sad_panda.svg',
                                  color: Colors.black45,
                                  height: 100,
                                ),
                                Text(
                                  AppConfig.currenlyNoOrder,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black45),
                                ),
                              ],
                            ),
                          ))
                        :
                        //orders available
                        buildSingleChildScrollView(
                            PendingOrders(orderProvider: orderProvider),
                            ActiveOrders(
                              orderProvider: orderProvider,
                            ))
                    :
                    //seller offline
                    buildSingleChildScrollView(
                        TextContainer(text: AppConfig.availableError),
                        ActiveOrders(
                          orderProvider: orderProvider,
                        ));
              }),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(w1, w2) {
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
