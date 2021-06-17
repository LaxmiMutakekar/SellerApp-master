import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/Screens/productDetail/productDetail.dart';
import 'package:Seller_App/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/models/products.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Seller_App/widgets/switchButton.dart';

class Catalogue extends StatefulWidget {
  static String routeName = "/catalogue";

  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Product>(context, listen: false).addProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(builder: (context, Product products, child) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Catalogue",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RawScrollbar(
              thumbColor: Colors.black45,
              isAlwaysShown: true,
              controller: _scrollController,
              thickness: 4,
              //isAlwaysShown: true,
              radius: Radius.circular(10),
              child: ListView.builder(
                controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: products.productsList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Products product = products.productsList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              product: product,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Cards(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: getProportionateScreenWidth(125),
                                    height: getProportionateScreenHeight(125),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13)),
                                    clipBehavior: Clip.hardEdge,
                                    child: Hero(
                                      tag: product.skuId,
                                      child: CachedNetworkImage(
                                        imageUrl: product.image,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                product.name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            DefaultSwitch(
                                              value: product.available,
                                              type: 'Product',
                                              model: products,
                                              product: product,
                                            )
                                          ],
                                        ),
                                        Text(
                                          product.skuId.toString(),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width: 180,
                                          child: Text(
                                            product.description.trim(),
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15),
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "\$ " + product.price.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
            ),
          ));
    });
  }
}
