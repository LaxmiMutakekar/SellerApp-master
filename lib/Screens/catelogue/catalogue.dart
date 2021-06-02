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
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: products.productsList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Products item = products.productsList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            image: item.image,
                            name: item.name,
                            skuId: item.skuId,
                            ean: item.ean,
                            upc: item.upc,
                            description: item.description.trim(),
                            price: item.price,
                            basicEta: item.basicEta,
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
                                    tag: item.name,
                                    child: CachedNetworkImage(
                                      imageUrl: item.image,
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
                                              item.name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DefaultSwitch(
                                            value: item.available,
                                            type: 'Product',
                                            model: products,
                                            product: item,
                                          )
                                        ],
                                      ),
                                      Text(
                                        item.skuId,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: 180,
                                        child: Flexible(
                                                  child: Text(
                                            item.description.trim(),
                                            textAlign: TextAlign.justify,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        "\$ " + item.price.toString(),
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
          ));
    });
  }
}
