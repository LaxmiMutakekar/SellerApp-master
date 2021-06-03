import 'package:Seller_App/models/orders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../totalPriceContainer.dart';

class DefaultOrderDetail extends StatelessWidget {
   DefaultOrderDetail({
    Key key,
    @required this.order,
  }): super(key: key);

  final Orders order;
    final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                    },
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(order.customer.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2),
                            Text("Ordered by"),
                          ],
                        ),
                        Icon(Icons.expand_more),
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                Text(
                  order.placedTime,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff9E545E),
                  ),
                ),
                Text(
                  'Ordered at',
                ),
              ],
            ),
          ],
        ),
        const Divider(
          height: 17,
          thickness: 2,
        ),
        Container(
          child: RawScrollbar(
            thumbColor: Colors.black,
            isAlwaysShown: true,
            controller: _scrollController,
            thickness: 4,
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: order.orderItems.length,
                itemBuilder: (context, int index) {
                  return Container(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 60,
                                  width: 70,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(13),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: order
                                          .orderItems[index]
                                          .image,
                                      placeholder: (context,
                                              url) =>
                                          CircularProgressIndicator(),
                                      errorWidget:
                                          (context, url, error) =>
                                              Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.orderItems[index]
                                        .productName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    child: Text(
                                      order.orderItems[index]
                                              .price
                                              .toString()+
                                      'X ' +
                                          order.orderItems[index]
                                              .quantity
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$' +
                              (order.orderItems[index].quantity *
                                      order.orderItems[index].price)
                                  .toString(),
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff0D2F36),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        Stack(
          children: [
            ClipPath(
              child: Container(
                  width: 470,
                  height: 70,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Items',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              order.totalQuantity.toString(),
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, right: 10),
                            child: Column(children: [
                              Text(
                                '\$' + order.totalPrice.toString(),
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Center(
                                  child: Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              )),
                            ]),
                          ),
                        ],
                      )
                    ],
                  )),
              clipper: CustomClipPath(),
            ),
            CustomPaint(
                painter: BorderPainter(),
                child: Container(
                  height: 70.0,
                  width: 470,
                )),
          ],
        ),
      ],
    );
  }
}