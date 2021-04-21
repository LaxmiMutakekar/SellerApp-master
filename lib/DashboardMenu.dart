import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'RejectedOrders.dart';
import 'providers/tokenModel.dart';
import 'package:provider/provider.dart';
import 'pendingOrders.dart';
import 'activeOrders.dart';
import 'api/apiService.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with TickerProviderStateMixin {
  final storage = new FlutterSecureStorage();
  bool isSwitched = false;

  bool isDrawerOpen = false;
  double screenwidth, screenheight;

  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
   AnimationController controllerOne;
  Animation<Color> animationOne;
  Animation<Color> animationTwo;
  @override
  void initState() {
   
    super.initState();
     
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
        controllerOne = AnimationController(
        duration: Duration(milliseconds: 2000),
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
      //this.setState((){});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    controllerOne.dispose();
    
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;
    return Consumer<TokenModel>(builder: (context, value, child) {
      return Scaffold(
        body: Stack(
          children: [
            menu(context, value.token),
            dashboard(context, value.token),
          ],
        ),
      );
    });
  }

  Widget menu(context, token) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          color: Color(0xff393E43),
          padding: EdgeInsets.only(top: 70, bottom: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  IconButton(
                      icon: Icon(Icons.account_circle, color: Colors.white),
                      onPressed: null),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        FutureBuilder(
                            future: APIService.fetchName(context, token),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold));
                              } else {
                                return   ShaderMask(
                shaderCallback: (rect){
                  return LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [animationOne.value,animationTwo.value]).createShader(rect,textDirection: TextDirection.ltr);
                },
                child:Text(''));
                              }
                            }),
                      ])
                ]),
                Column(
                  children: [
                    Row(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              // Catalogue();
                            },
                            label: Text(
                              'Catalogue',
                              style: TextStyle(color: Colors.white),
                            ),
                            icon:
                                Icon(Icons.shopping_cart, color: Colors.white))
                      ],
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            //OrderHistory();
                          },
                          icon: Icon(
                            Icons.history,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Order history',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RejectedOrders()),
                              );
                            },
                            label: Text(
                              'Rejected Orders',
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(Icons.cancel, color: Colors.white))
                      ],
                    ),
                  ],
                ),
                Row(children: [
                  SizedBox(width: 10),
                  TextButton.icon(
                    onPressed: () {
                      //Settings();
                    },
                    icon: Icon(Icons.settings, color: Colors.white),
                    label: Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  TextButton.icon(
                    onPressed: () async {
                      Provider.of<TokenModel>(context, listen: false)
                          .addToken("");
                      await storage.delete(key: "token");
                    },
                    icon: Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ])
              ]),
        ),
      ),
    );
  }

  Widget dashboard(context, token) {
    var count=0;
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;

    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isDrawerOpen ? 0.5 * screenwidth : 0,
      right: isDrawerOpen ? -0.2 * screenwidth : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: isDrawerOpen?BorderRadius.circular(40):BorderRadius.circular(0),
                  child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Color(0xffE5E5E5),
                  height: MediaQuery.of(context).size.height,
                  child: ListView(scrollDirection: Axis.vertical, children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDrawerOpen
                                ? IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      setState(() {
                                        isDrawerOpen = !isDrawerOpen;
                                        _controller.reverse();
                                      });
                                    })
                                : IconButton(
                                    icon: Icon(Icons.menu),
                                    onPressed: () {
                                      setState(() {
                                        isDrawerOpen = !isDrawerOpen;
                                        _controller.forward();
                                      });
                                    }),
                            Column(children: [
                              FutureBuilder(
                                  future: APIService.fetchName(context, token),
                                  builder: (context, snapshot) {
                                    count++;
                                    print('DashboardCount'+count.toString());
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data);
                                    } else {
                                      return ShaderMask(
                shaderCallback: (rect){
                  return LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [animationOne.value,animationTwo.value]).createShader(rect,textDirection: TextDirection.ltr);
                },
                child:Container(color: Colors.white,
                  height:20,width:80));
                                    }
                                  }),
                              FutureBuilder(
                                  future: APIService.fetchAvail(context, token),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      isSwitched = snapshot.data;
                                      return FlutterSwitch(
                                          activeSwitchBorder: Border.all(
                                              width: 2, color: Colors.green),
                                          activeColor: Colors.white,
                                          activeToggleColor: Colors.green,
                                          inactiveToggleBorder: Border.all(
                                              width: 3.0, color: Colors.black),
                                          activeToggleBorder: Border.all(
                                              width: 2.0, color: Colors.green),
                                          width: 45.0,
                                          height: 20.0,
                                          valueFontSize: 10.0,
                                          activeTextColor: Colors.green,
                                          toggleSize: 18.0,
                                          value: isSwitched,
                                          borderRadius: 15.0,
                                          padding: 0.0,
                                          showOnOff: true,
                                          onToggle: (val) {
                                            setState(() {
                                              isSwitched = val;

                                              Widget cancelButton = FlatButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  setState(() {});
                                                  isSwitched = !val;
                                                  val = isSwitched;

                                                  APIService.updateAvailable(
                                                      val, token);
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                              Widget continueButton =
                                                  FlatButton(
                                                child: val
                                                    ? Text("Go online")
                                                    : Text('Go Offline'),
                                                onPressed: () {
                                                  setState(() {});
                                                  APIService.updateAvailable(
                                                      val, token);
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                  //updateAvailable(val,token);
                                                },
                                              );
                                              // set up the AlertDialog
                                              AlertDialog alert = AlertDialog(
                                                title: Text("Warning!"),
                                                content: val
                                                    ? Text(
                                                        "Are you sure you want to go online")
                                                    : Text(
                                                        "Are you sure you want to go Offline"),
                                                actions: [
                                                  cancelButton,
                                                  continueButton,
                                                ],
                                              );
                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            });
                                          });
                                    } else {
                                      return ShaderMask(
                shaderCallback: (rect){
                  return LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [animationOne.value,animationTwo.value]).createShader(rect,textDirection: TextDirection.ltr);
                },
                child:Container(color: Colors.white,width: 40,height: 10,));
                                    }
                                  })
                            ]),
                            IconButton(
                                icon: Icon(Icons.notifications_active),
                                onPressed: null)
                          ],
                        ),
                        Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Pending Orders',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                        FutureBuilder(
                          future: APIService.fetchAvail(context, token),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data) {
                                return Column(
                                  children: [
                                    
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: PendingOrders(),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical:16),
                                    child: Card(
                                      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                                      color: Colors.white,
                                      elevation: 10,
                                      child: Container(
                                        height: 170,
                                        width: 300,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                          Icon(
                                            Icons.block_rounded,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                                'You cant receive orders as you are offline, if you have any pending orders please fulfill them ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                  fontWeight: FontWeight.w300)),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else
                              return ShaderMask(
                shaderCallback: (rect){
                  return LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [animationOne.value,animationTwo.value]).createShader(rect,textDirection: TextDirection.ltr);
                },
                child: Container(color: Colors.white,
                  height:156,width:MediaQuery.of(context).size.width,));
                          },
                        ),
                        SizedBox(
                          height:20,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height*0.8),
                                                  child: Container(
                            width: screenwidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only( topLeft:Radius.circular(30),topRight: Radius.circular(30)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '\nActive Orders',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                ActiveOrders()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
