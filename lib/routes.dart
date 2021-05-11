import 'package:Seller_App/Screens/HomeScreen/Home.dart';
import 'package:Seller_App/Screens/catelogue/catalogue.dart';
import 'package:Seller_App/Screens/loginScreen/loginScreen.dart';
import 'package:Seller_App/Screens/orderHistory/orderHistory.dart';
import 'package:Seller_App/Screens/productDetail/productDetail.dart';
import 'package:Seller_App/Screens/profileScreen.dart';
import 'package:Seller_App/Screens/rejectedOrder/rejectedOrders.dart';
import 'package:Seller_App/Screens/submittedScreen.dart';
import 'package:Seller_App/Screens/verifyScreen.dart';
import 'package:Seller_App/root.dart';
import 'package:flutter/cupertino.dart';

final Map<String,WidgetBuilder> routes={
  RootPage.routeName:(content)=>RootPage(),
  LoginPage.routeName:(context)=>LoginPage(),
  HomeScreen.routeName:(context)=>HomeScreen(),
  Catalogue.routeName:(context)=>Catalogue(),
  OrderHistory.routeName:(context)=>OrderHistory(),
  RejectedOrders.routeName:(context)=>RejectedOrders(),
  Verify.routeName:(context)=>Verify(),
  SubmitPage.routeName:(context)=>SubmitPage(),
  ProfilePage.routeName:(context)=>ProfilePage(),
  ProductDetails.routeName:(context)=>ProductDetails(),
};