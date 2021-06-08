import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/Screens/internetError.dart';
import 'package:Seller_App/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:connectivity/connectivity.dart';

class IsConnected extends StatelessWidget {
  static String routName = '/connectionCheck';

  @override
  Widget build(BuildContext context) {
    return Material(child: Builder(
      builder: (BuildContext context) {
        return OfflineBuilder(
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              //checks the device connectivity
              final bool connected = connectivity != ConnectivityResult.none;
              //if connected go to root else show internetError
              return (connected) ? RootPage() : InternetError();
            },
            child: Container());
      },
    ));
  }
}
