import 'package:Seller_App/Screens/homeScreen/Home.dart';
import 'package:Seller_App/providers/orderProvider.dart';
import 'package:Seller_App/providers/seller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'APIServices/APIServices.dart';
import 'Screens/serverErrorScreen.dart';
import 'models/sellerDetails.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final seller = Provider.of<SellerProvider>(context, listen: false);
    return FutureBuilder(
        //fetches a seller from server by http get request
        future: APIServices.fetchSeller(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            //if response is Seller type then store seller and go to HomeScreen
            if (snapshot.data.runtimeType == Seller) {
              seller.seller = snapshot.data;
              return HomeScreen();
            }
            //else show error in server
            return ServerError();
          } else {
            return Container();
          }
        });
  }
}
