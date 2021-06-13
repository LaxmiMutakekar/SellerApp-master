import 'package:Seller_App/models/products.dart';
import 'package:Seller_App/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';

class ProductDetails extends StatelessWidget {
  final Products product;

  const ProductDetails({Key key, this.product}) : super(key: key);
  static String routeName = "/productDetail";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Hero(
                tag: product.pid,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 5,
              child: Container(
                height: 40,
                width: 40,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Positioned(
              top: 350.0,
              left: 20,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      div(),
                      buildText("skuId", product.skuId, context),
                      buildText("upc", product.upc, context),
                      buildText("ean", product.ean, context),
                      div(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Price",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                "\$ " + product.price.toString(),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.black,
                            thickness: 2,
                            width: 5,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "Basic ETA",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                product.basicEtc.toString() + " mins",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String t1, String t2, BuildContext context) {
    return Row(
      children: [
        Text(
          t1 + ": ",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          t2,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  div() {
    return const Divider(
      height: 17,
      thickness: 2,
      indent: 0,
      endIndent: 0,
    );
  }
}
