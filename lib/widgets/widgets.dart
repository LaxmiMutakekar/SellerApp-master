import 'package:Seller_App/providers/seller.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:google_fonts/google_fonts.dart';

String productName(List<OrderItem> data) {
  String productNames = "";
  String firstHalf = "";
  for (int i = 0; i < data.length; i++) {
    if (i == data.length - 1) {
      productNames += data[i].productName + " ";
    } else {
      {
        productNames += data[i].productName + ", ";
      }
    }
  }
  if (productNames.length > 15) {
    for (int i = 0; i < 15; i++) {
      firstHalf += productNames[i];
    }
    productNames = firstHalf + "...";
  }
  return productNames;
}

void showInSnackBar(String value, BuildContext context) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    content: new Text(
      value,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.green[300],
  ));
}
Container currentlyNoOrders(context)
{
  return Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                
                          'Currently you dont have any orders!!!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                                textStyle: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600)),
                        ),
                            )),
                      );
}

Container noPendingOrders() {
  return Container(
      child: Padding(
    padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 40),
    child: Cards(
        child: Column(
          children: [
            Icon(FluentIcons.emoji_16_regular),
            Text(
      'No new orders are received',
      textAlign: TextAlign.center,
      
    ),
          ],
        )),
  ));
}

Container errorBox() {
  return Container(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: Container(
            height: AppConfig.errorBoxHeight,
            width: AppConfig.errorBoxwidth,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.block_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        'You cant receive orders as you are offline, if you have any pending orders please fulfill them ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  )
                ]),
          ),
        ),
      ),
    ),
  );
}
