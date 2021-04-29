import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/sellerDetails.dart';
class SellerDetail extends ChangeNotifier{
   Seller seller=new Seller();
  void fetchSeller()async
  {
    seller=await APIServices.fetchSeller();
    notifyListeners();
  }
  void changeAvailabiliy(bool value)
  {
    seller.available=value;
    notifyListeners();
  }

}