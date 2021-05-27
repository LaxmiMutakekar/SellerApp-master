import 'package:Seller_App/Screens/homeScreen/drawerScreen/drawer.dart';
import 'package:Seller_App/Screens/homeScreen/mainScreen/mainScreen.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/products.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName="/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer2<Update, SellerDetail>(
        builder: (context, Update orders, seller, child) {
    return Material(
      child: Scaffold(
          body: Stack(
        children: [
         MenuDashboard(orderProvider:orders,sellerProvider:seller),
         MainScreen(orderProvider:orders,sellerProvider:seller)
        ],
      )),
    );
        });
  }
}
