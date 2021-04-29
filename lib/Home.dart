import 'package:Seller_App/providers/seller.dart';
import 'package:flutter/material.dart';
import 'providers/products.dart';
import 'screens/mainScreen.dart';
import 'screens/drawer.dart';
import 'package:provider/provider.dart';
import 'providers/orderUpdate.dart';

class HomeScreen extends StatefulWidget {
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
