import 'package:Seller_App/Screens/loginScreen/loginScreen.dart';
import 'package:Seller_App/Screens/orderHistory/orderHistory.dart';
import 'package:Seller_App/Screens/profileScreen.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Seller_App/Screens/catelogue/catalogue.dart';
import 'package:Seller_App/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Seller_App/Screens/rejectedOrder/rejectedOrders.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/App_configs/app_configs.dart';

class MenuDashboard extends StatefulWidget {
  static String routeName="/drawer";
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<SellerDetail>(builder: (context,seller, child) {
      return SafeArea(
              child: Material(
          child: Container(
              color: AppConfig.drawerBackground,
              padding: EdgeInsets.only(top: 70, bottom: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
          Row(children: [
            IconButton(
                icon: Icon(Icons.account_circle, color: Colors.white),
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    ProfilePage.routeName);
                }),
            SizedBox(
              width: 10,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: GoogleFonts.raleway(textStyle:TextStyle(color:Colors.white,fontSize: 18 ))
                  ),
                  Text(seller.seller.name==null?('Loading..'):seller.seller.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ])
          ]),
          Column(
            children: [
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Catalogue.routeName
                        );
                        // Catalogue();
                      },
                      label: Text(
                        'Catalogue',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon:
                          Icon(Icons.shopping_cart, color: Colors.white))
                ],
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                          context,
                          OrderHistory.routeName
                          );
                    },
                    icon: Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Order history',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RejectedOrders.routeName
                        );
                      },
                      label: Text(
                        'Rejected Orders',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(Icons.cancel, color: Colors.white))
                ],
              ),
            ],
          ),
          Row(children: [
            SizedBox(width: 10),
            TextButton.icon(
              onPressed: () {
                //Settings();
              },
              icon: Icon(Icons.settings, color: Colors.white),
              label: Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 2,
              height: 20,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            TextButton.icon(
              onPressed: () {
                Session.logout();
                Navigator.pushNamed(
                  context,
                  LoginPage.routeName
                );
              },
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ])
                  ]),
            ),
        ),
      );
    });
  }
}
