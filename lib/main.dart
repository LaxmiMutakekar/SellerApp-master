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
import 'providers/notification.dart';
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
      ChangeNotifierProvider<NotificationCount>(
        create: (_) => NotificationCount(),
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
      home: Text('seller App'),
    );
  }
// }
// class BellIcon extends StatefulWidget {
//   @override
//   _BellIconState createState() => _BellIconState();
// }

// class _BellIconState extends State<BellIcon>with SingleTickerProviderStateMixin {
//   Animation<double> animation; //animation variable for circle 1
//   AnimationController animationcontroller;
//   @override
//   void initState() {
//     animationcontroller = AnimationController(vsync: this, duration: Duration(seconds: 1));
//     //here we have to vash vsync argument, there for we use "with SingleTickerProviderStateMixin" above
//     //vsync is the ThickerProvider, and set duration of animation
    
//     animationcontroller.repeat();
//     //repeat the animation controller

//     animation = Tween<double>(begin: 17, end:20).animate(animationcontroller);
//     //set the begin value and end value, we will use this value for height and width of circle

//     animation.addListener(() {
//          setState(() { }); 
//          //set animation listiner and set state to update UI on every animation value change
//     });
    
//     super.initState();
//   }
//    @override
//   void dispose() {
//       super.dispose();
//       animationcontroller.dispose(); //destory anmiation to free memory on last
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           body: Center(
//             child: Container(
//         child:Stack(children: [
//             SizedBox(
//               width: 60,
//               height: 60,
//               child: Icon(
//                                       Icons.notifications_none,
//                                       size: 30,
//                                       //color: AppConfig.iconColor,
//                                     ),
//             ),
//                                 Positioned(
//                                   right: 30,
//                                   //top: 30,
//                                                                   child: Container(
//                                     height: animation.value,
//                                     width: animation.value,
//                                         decoration: BoxDecoration(
                                         
//                                           borderRadius: BorderRadius.circular(10),
//                                           color: Colors.red
//                                         ),
//                                       ),
//                                 ),
//         ],)
//       ),
//           ),
//     );
//   }
// 
}
