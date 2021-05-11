import 'package:Seller_App/providers/seller.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/products.dart';
import 'package:Seller_App/Screens/HomeScreen/mainScreen/mainScreen.dart';
import 'package:Seller_App/Screens/HomeScreen/drawerScreen/drawer.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/providers/orderUpdate.dart';

class HomeScreen extends StatefulWidget {
  static String routeName="/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Update>(context, listen: false).ordersAdded();
    Provider.of<SellerDetail>(context, listen: false).fetchSeller();
    Provider.of<Product>(context, listen: false).addProducts();

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          body: Stack(
        children: [
          MenuDashboard(),
          MainScreen(),
        ],
      )),
    );
  }
}
