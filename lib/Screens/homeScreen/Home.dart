import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/FireBase/firebase_config.dart';
import 'package:Seller_App/Screens/homeScreen/drawerScreen/drawer.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/mainScreen.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:Seller_App/widgets/bubbleNotification.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/products.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseConfig().init(context);
    //fetch the orders related to this seller
    Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<OrderProvider, SellerProvider>(
        builder: (context, OrderProvider order, seller, child) {
      return Material(
        child: Scaffold(
            body: Stack(
          children: [
            MenuDashboard(orderProvider: order, sellerProvider: seller),
            MainScreen(orderProvider: order, sellerProvider: seller),
            (order.cancelledStatus)? SafeArea(
              child: Stack(
                children: [
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(180/ 360),
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0,top: 20,bottom: 20,right: 66),
                      child: Opacity(
                        opacity: 0.8,
                        child: CustomPaint(
                          painter: NotificationBox(color: Colors.red[200],alignment: Alignment.topLeft),
                            child: Container(width: 300,height: 50,

                            )),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                      left: 100,
                      child: Text('Order got cancelled',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
                ],
              ),
            ):Container(),

          ],
        )),
      );
    });
  }
}
