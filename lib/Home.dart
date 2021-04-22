import 'package:flutter/material.dart';
import 'package:order_listing/App_configs/app_configs.dart';
import 'package:order_listing/drawer.dart';
import 'package:order_listing/mainScreen.dart';
import 'package:order_listing/widgets/cards.dart';
import 'package:order_listing/widgets/widgets.dart';
import 'pendingOrders.dart';
import 'activeOrders.dart';
import 'package:provider/provider.dart';
import 'providers/orderUpdate.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Material(
          child: Scaffold(
        
         body: Stack(
            children: [
              MenuDashboard(),
              MainScreen(),
            ],
         )
      ),
    );
  }
}
