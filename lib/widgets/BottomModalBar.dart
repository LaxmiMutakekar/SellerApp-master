import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/screens/verifyScreen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderDetail {
  DateTime fulfillmentTime;
  String time;
  @override
  void settingModalBottomSheet(context, Orders item,int index) {
    final ScrollController _scrollController = ScrollController();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            color: Color(0xffCCCCCD),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Color(0xff6D6D6D),
                    child: Container(
                      child: buildBottomSheet(item, context, _scrollController,index),
                      decoration: BoxDecoration(
                          color: Color(0xffCCCCCD),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  buildBottomSheet(item, BuildContext context, scrollController,index) {
    fulfillmentTime = item.orderPlacedDate;
    time = DateFormat.jm().format(fulfillmentTime
        .add(Duration(minutes: item.orderFulfillmentTime.toInt())));

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
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
              Row(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 60,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showAlertDialog(item.customer, context);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      item.customer.name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.expand_more),
                                  ],
                                )),
                            Text(
                              'Customer Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        SizedBox(width: 50),
                        Column(
                          children: [
                            Text(
                              time,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff9E545E),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Order Fulfillment Time',
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    )
                  ]),
                ],
              ),
              const Divider(
                height: 17,
                thickness: 2,
                indent: 15,
                endIndent: 15,
                color: Colors.white,
              ),
              item.deliveryResource.driverName != null
                  ? Container(
                      child: Column(
                        children: [
                          Row(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Icon(
                                    Icons.account_circle_sharp,
                                    size: 60,
                                  ),
                                ),
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          showDriver(
                                              item.deliveryResource, context);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              item.deliveryResource.driverName,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(Icons.expand_more),
                                          ],
                                        )),
                                    Text(
                                      'Driver Name',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                ),
                              ]),
                          const Divider(
                            height: 17,
                            thickness: 2,
                            indent: 15,
                            endIndent: 15,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height / 3,
                child: RawScrollbar(
                  thumbColor: Colors.black,
                  isAlwaysShown: true,
                  controller: scrollController,
                  thickness: 4,
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: item.orderItems.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 90,
                                      width: 87,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              item.orderItems[index].skuId,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              height: 60,
                                              width: 70,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl: item
                                                      .orderItems[index].image,
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '\$' +
                                                item.orderItems[index].price
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff0D2F36)),
                                          ),
                                        ],
                                      )),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.orderItems[index].productName,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                            child: Text(
                                          'X ' +
                                              item.orderItems[index].quantity
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.black),
                                        )),
                                      ]),
                                  Text(
                                    '\$' +
                                        (item.orderItems[index].quantity *
                                                item.orderItems[index].price)
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0xff0D2F36),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, top: 16, bottom: 8),
                child: Stack(
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
                                      item.totalQuantity.toString(),
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
                    CustomPaint(
                        painter: BorderPainter(),
                        child: Container(
                          height: 70.0,
                          width: 470,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Consumer<Update>(
                        builder: (context, Update orders, child) {
                      return item.deliveryResource.driverName != null
                          ? Container(
                              width: 120,
                              child: item.status != 'Order Complete'
                                  ? RaisedButton(
                                      elevation: 10,
                                      color: Colors.black,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delivery_dining,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            " Handover",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Verify(
                                                      oid: item.orderId,index: index,
                                                    )));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)))
                                  : Container(
                                      width: 600,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                      
                                      child: Text(
                                        
                                        'Order completed successfully!!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                            )
                          : Container();
                    }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
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

showDriver(DeliveryResource dri, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Driver Details"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Driver name: " + dri.driverName),
        Text("Phone number: " + dri.phone.toString()),
        Text("Licence number: " + dri.licenseNumber),
        Text("threePLName: " + dri.threePlName),
        Text("Vehicle number: " + dri.vehicleNumber)
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
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BorderPainter extends CustomPainter {
  var radius = 30.0;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.black;
    Path path = Path();
    path.moveTo(size.width / 12, 0);
    var firstEnd = new Offset(0, size.height / 3);
    var firstControl = new Offset(0, 0);
    path.quadraticBezierTo(
        firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);
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
    path.lineTo(size.width, size.height / 4 + 10);
    var fifthEnd = new Offset(size.width - radius, 0);
    var fifthControl = new Offset(size.width, 0);
    path.quadraticBezierTo(
        fifthControl.dx, fifthControl.dy, fifthEnd.dx, fifthEnd.dy);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
