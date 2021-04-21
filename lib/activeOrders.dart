import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/tokenModel.dart';
import 'orderDetails.dart';
import 'providers/statusUpdate.dart';
import 'package:provider/provider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'model/orders.dart';
import 'api/apiService.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders>with SingleTickerProviderStateMixin {
  CountDownController _controller = CountDownController();
  String url;
  var count=0;
  OrderDetail orders = new OrderDetail();
   AnimationController controllerOne;
  Animation<Color> animationOne;
  Animation<Color> animationTwo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerOne = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this);
    animationOne = ColorTween(begin: Colors.black38,end: Colors.white24).animate(controllerOne);
    animationTwo = ColorTween(begin: Colors.white24,end: Colors.black38).animate(controllerOne);
    controllerOne.forward();
    controllerOne.addListener((){
      if(controllerOne.status == AnimationStatus.completed){
        controllerOne.reverse();
      } else if(controllerOne.status == AnimationStatus.dismissed){
        controllerOne.forward();
      }
      this.setState((){});
    });
  }
  @override
  void dispose() {
    super.dispose();
   
    controllerOne.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<TokenModel, StatusUpdate>(
        builder: (context, value, child, val) {
      return Container(
        child: FutureBuilder(
          future: APIService.fetchOrders(context, value.token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Orders item = snapshot.data[index];
                  switch (item.businessUnit) {
                    case 'Sodimac':
                      url = 'assets/sodi.png';
                      break;
                    case 'Tottus':
                      url = 'assets/tottus.png';
                      break;
                    default:
                  }

                  if (item.status == 'Order Preparing') {
                    return GestureDetector(
                      onTap: () {
                        orders.settingModalBottomSheet(context, item);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.grey[200],
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 180,
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(url))),
                                    ),
                                    CircularCountDownTimer(
                                      width: 60.0,
                                      height: 60.0,
                                      duration:
                                          item.orderPreparationTime.toInt() *
                                              60,
                                      fillColor: Colors.amber,
                                      ringColor: Colors.white,
                                      controller: _controller,
                                      backgroundColor: Colors.white54,
                                      strokeWidth: 5.0,
                                      strokeCap: StrokeCap.round,
                                      isTimerTextShown: true,
                                      isReverse: true,
                                      onComplete: () {},
                                      textStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Text(
                                  '#00${item.orderId}',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  item.customer.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                                const Divider(
                                  height: 5,
                                  thickness: 3,
                                  indent: 10,
                                  endIndent: 40,
                                ),
                                Container(
                                  width: 400,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Row(
                                          children: [
                                            RaisedButton(
                                              hoverColor: Colors.blueGrey,
                                              onPressed: () {
                                                setState(() {});
                                              },
                                              color: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Text("Mark as Done",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(width: 5),
                                            RaisedButton(
                                              hoverColor: Colors.blueGrey,
                                              onPressed: () {},
                                              color: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Text("Update ETC",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            }
            return ShaderMask(
                shaderCallback: (rect){
                  return LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [animationOne.value,animationTwo.value]).createShader(rect,textDirection: TextDirection.ltr);
                },
                child: Container(
                  child: Center(
                    child: Column(
                        children: [
                          Container(
                            height:200,width:MediaQuery.of(context).size.width*0.9,
                            decoration: (BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20))
                            ),
                          ),
                            SizedBox(height:20),
                            Container(
                            height:200,width:MediaQuery.of(context).size.width*0.9,
                            decoration: (BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20))
                            ),
                            ),
                        ],
                      ),
                  ),
                ));
          },
        ),
      );
    });
  }
}
