import 'package:Seller_App/App_configs/sizeConfigs.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderItemList extends StatelessWidget {
  OrderItemList({this.order});

  final Orders order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: order.orderItems.length,
        itemBuilder: (context, int index) {
          return Container(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            width: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: order.orderItems[index].image,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.orderItems[index].productName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                child: Text(
                                  '\$' + order.orderItems[index].price.toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(flex: 8,),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                width: getProportionateScreenWidth(25),
                                height: getProportionateScreenHeight(25),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.black),
                                child: Center(
                                  child: Text(
                                    order.orderItems[index].quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              Text(' Item')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
