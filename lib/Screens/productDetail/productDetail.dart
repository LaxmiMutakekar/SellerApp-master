import 'package:Seller_App/Screens/catelogue/catalogue.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/src/cached_image_widget.dart';

class ProductDetails extends StatefulWidget {
  final String image;
  final String name;
  final String skuId;
  final String ean;
  final String upc;
  final String description;
  final double price;
  final double basicEta;
  const ProductDetails({
    Key key,
    this.image,
    this.name,
    this.skuId,
    this.ean,
    this.upc,
    this.description,
    this.price,
    this.basicEta,
  }) : super(key: key);
  static String routeName="/productDetail";
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Hero(
              tag: widget.name,
              child: CachedNetworkImage(
                imageUrl: widget.image,
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
              // padding: EdgeInsets.symmetric(horizontal: 20),
              // margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
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
                      widget.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    div(),
                    buildText("skuId", widget.skuId),
                    buildText("upc", widget.upc),
                    buildText("ean", widget.ean),
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
                              "\$ " + widget.price.toString(),
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
                              widget.basicEta.toString()+" mins",
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
    );
  }

  Widget buildText(String t1, String t2) {
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

  Widget div() {
    return const Divider(
      height: 17,
      thickness: 2,
      indent: 0,
      endIndent: 0,
    );
  }
}