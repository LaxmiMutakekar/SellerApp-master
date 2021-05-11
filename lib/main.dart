import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:Seller_App/routes.dart';
import 'package:flutter/material.dart';
import 'providers/orderUpdate.dart';
import 'providers/products.dart';
import 'root.dart';
import 'package:provider/provider.dart';
import 'session.dart';
import 'App_configs/theme.dart';
import 'package:Seller_App/FireBase/firebase_config.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Session.init();
  runApp(MultiProvider(
    providers: [

      ChangeNotifierProvider<Product>(
        create: (_) => Product(),
      ),
      ChangeNotifierProvider<Update>(
        create: (_) => Update(),
      ),
      ChangeNotifierProvider<SellerDetail>(
        create: (_) => SellerDetail(),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SellerDetail>(context, listen: false).fetchSeller();
    //SizeConfig().init(context);
    FirebaseConfig().init(context);

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(context),
      routes: routes,
      initialRoute: RootPage.routeName,
      debugShowCheckedModeBanner: false,
      title: 'Seller App',
      home: Text('Seller App'),
    );
  }
}