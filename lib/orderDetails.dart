import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'model/orders.dart';

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
              color: Color(0xFF737373),
              child: Container(
                child: buildBottomSheet(item),
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

  Column buildBottomSheet(item) {
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
                child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.account_circle_sharp,
                    size: 60,
                  ),
                  SizedBox(
                    width:10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.customer,style: TextStyle(fontSize:22,fontWeight: FontWeight.bold ),),
                      Text('Customer Name',style: TextStyle(fontSize:18,fontWeight: FontWeight.w200 ),),
                      
                    ],
                  )
                ]),
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
                  itemCount: item.orderItem.length,
                  itemBuilder: (context, int index) {
                    switch (item.orderItem[index].productName) {
                      case 'Pizza':
                        url = 'assets/pizza.jpeg';
                        break;
                      case 'Burger':
                        url = 'assets/burger.jpeg';
                        break;
                      default:
                    }

                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Container(
                              //   width: 80,
                              //   height: 80,
                              //   child: Hero(
                              //     tag: url,
                              //     child: Container(
                              //       height: 30,
                              //       width: 30,
                              //         decoration: new BoxDecoration(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(6.0)),
                              //             image: new DecorationImage(
                              //                 fit: BoxFit.contain,
                              //                 image: AssetImage(url)))),
                              //   ),
                              // ),
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
                                        height: 56,
                                        width: 70,
                                        decoration: new BoxDecoration(
                                            borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                            image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(url))),
                                      )),
                                    ),
                                ),
                              
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.orderItem[index].productName,
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.normal),
                                    ),
                                    Text('SKU ID:' + item.orderItem[index].skuId,style: TextStyle(fontSize: 10),),
                                    Text(
                                      '\$' + item.orderItem[index].price.toString(),
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.bold,color: Color(0xff0D2F36)),
                                    ),
                                    SizedBox(width: 5),
                                  ]),
                              Container(
                                  
                                  height: 35,
                                  width: 87,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.white),
                                    child: Text(
                                      item.orderItem[index].quantity.toString(),
                                      style: TextStyle(fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )),
                              Text(
                                '\$' +
                                    (item.orderItem[index].quantity *
                                            item.orderItem[index].price)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xff0D2F36),fontWeight: FontWeight.bold),
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
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text('Items',style: TextStyle(fontSize: 20),),
                            ),
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              '5',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:12.0,right:35),
                            child: Column(
                              children:[
                                Text('\$'+item.totalPrice.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                               
                                Center(child: Text('Total',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),)),
                                
                              ]
                            ),
                          ),
                        ],
                      )

                    ],)
                  ),
                  clipper: CustomClipPath(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class CustomClipPath extends CustomClipper<Path> {
  var radius = 30.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height*0.7);
    path.moveTo(size.width/12, 0);
    var firstEnd=new Offset(0,size.height/3);
    var firstControl=new Offset(0,0);
    path.quadraticBezierTo(firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);
    //path.lineTo(0, size.height/3);
    var secondEnd=new Offset(radius,size.height*0.7);
    var secondControl=new Offset(0,size.height*0.7);
    path.quadraticBezierTo(secondControl.dx, secondControl.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width*0.7-10, size.height*0.7);
    var thirdEnd=new Offset(size.width*0.7+radius,size.height);
    var thirdControl=new Offset(size.width*0.7,size.height);
    path.quadraticBezierTo(thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);
    path.lineTo(size.width-radius,size.height);
    var forthEnd=new Offset(size.width,size.height-radius);
    var forthControl=new Offset(size.width,size.height);
    path.quadraticBezierTo(forthControl.dx, forthControl.dy, forthEnd.dx, forthEnd.dy);
    path.lineTo(size.width,size.height);
    
    path.lineTo(size.width, size.height/4+10);
    var fifthEnd=new Offset(size.width-radius,0);
    var fifthControl=new Offset(size.width,0);
    path.quadraticBezierTo(fifthControl.dx, fifthControl.dy, fifthEnd.dx, fifthEnd.dy);
    //path.quadraticBezierTo(thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
