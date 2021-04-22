import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:order_listing/models/orders.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderDetail {
  @override
  void settingModalBottomSheet(context, Orders item) {
    showModalBottomSheet(
        backgroundColor: Colors.blueAccent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 440,
                  color: Color(0xff6D6D6D),
                  child: Container(
                    child: buildBottomSheet(item, context),
                    decoration: BoxDecoration(
                        color: Color(0xffCCCCCD),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Column buildBottomSheet(item, BuildContext context) {
    String url;
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Order Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Divider(
                        height: 17,
                        thickness: 4,
                        indent: 130,
                        endIndent: 130,
                        color: Color(0xff393E43),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Icon(
                        Icons.account_circle_sharp,
                        size: 60,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                showAlertDialog(item.customer, context);
                              },
                              child: Text(
                                item.customer.name,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )),
                          Text(
                            'Customer Name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                        ],
                      )
                    ]),
                  ],
                ),
              ),
              const Divider(
                height: 17,
                thickness: 2,
                indent: 15,
                endIndent: 15,
                color: Colors.white,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: item.orderItems.length,
                  itemBuilder: (context, int index) {
                    print(item.orderItems[index].image);
                    
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Container(
                                    height: 73,
                                    width: 87,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 60,
                                        width: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          child: CachedNetworkImage(
        imageUrl: item.orderItems[index].image,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),
                                        ),
                                      ),
                                    )),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.orderItems[index].productName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      'SKU ID:' + item.orderItems[index].skuId,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      '\$' +
                                          item.orderItems[index].price
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff0D2F36)),
                                    ),
                                    SizedBox(width: 5),
                                  ]),
                              Container(
                                  height: 35,
                                  width: 87,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Text(
                                      item.orderItems[index].quantity
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )),
                              Text(
                                '\$' +
                                    (item.orderItems[index].quantity *
                                            item.orderItems[index].price)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff0D2F36),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipPath(
                  child: Container(
                      width: 400,
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
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  '7',
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
                                padding:
                                    const EdgeInsets.only(top: 12.0, right: 35),
                                child: Column(children: [
                                  Text(
                                    '\$' + item.totalPrice.toString(),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  showAlertDialog(Customer cust, BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Customer Details"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(cust.name),
          Text(cust.address),
          Text(cust.phone.toString())
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 30.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7);
    path.moveTo(size.width / 12, 0);
    var firstEnd = new Offset(0, size.height / 3);
    var firstControl = new Offset(0, 0);
    path.quadraticBezierTo(
        firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);
    //path.lineTo(0, size.height/3);
    var secondEnd = new Offset(radius, size.height * 0.7);
    var secondControl = new Offset(0, size.height * 0.7);
    path.quadraticBezierTo(
        secondControl.dx, secondControl.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width * 0.7 - 10, size.height * 0.7);
    var thirdEnd = new Offset(size.width * 0.7 + radius, size.height);
    var thirdControl = new Offset(size.width * 0.7, size.height);
    path.quadraticBezierTo(
        thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);
    path.lineTo(size.width - radius, size.height);
    var forthEnd = new Offset(size.width, size.height - radius);
    var forthControl = new Offset(size.width, size.height);
    path.quadraticBezierTo(
        forthControl.dx, forthControl.dy, forthEnd.dx, forthEnd.dy);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, size.height / 4 + 10);
    var fifthEnd = new Offset(size.width - radius, 0);
    var fifthControl = new Offset(size.width, 0);
    path.quadraticBezierTo(
        fifthControl.dx, fifthControl.dy, fifthEnd.dx, fifthEnd.dy);
    //path.quadraticBezierTo(thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
