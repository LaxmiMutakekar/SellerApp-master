import 'package:Seller_App/Screens/splashScreen.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:Seller_App/routes.dart';
import 'package:flutter/material.dart';
import 'providers/orderProvider.dart';
import 'providers/products.dart';
import 'root.dart';
import 'package:provider/provider.dart';
import 'session.dart';
import 'App_configs/theme.dart';
import 'package:Seller_App/FireBase/firebase_config.dart';
import 'providers/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Session.init();
  //Session.logout();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Product>(
        create: (_) => Product(),
      ),
      ChangeNotifierProvider<OrderProvider>(
        create: (_) => OrderProvider(),
      ),
      ChangeNotifierProvider<SellerProvider>(
        create: (_) => SellerProvider(),
      ),
      ChangeNotifierProvider<Messages>(
        create: (_) => Messages(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(context),
      routes: routes,
      debugShowCheckedModeBanner: false,
      title: 'Seller App',
      home: Splash(),
    );
  }
}
