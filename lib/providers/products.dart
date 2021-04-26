import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/models/products.dart';
class Product extends ChangeNotifier{
List<Products> productsList = [];
void addProducts() async {
     productsList=await APIServices.fetchProducts();
    notifyListeners();
  }
  void updateAvlb(int i,bool val){
    productsList[i].available=val;
    notifyListeners();

  }
  
}