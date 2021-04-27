import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/Home.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:animated_check/animated_check.dart';
class SubmitPage extends StatefulWidget {
  final int oid;
  final int index;
  const SubmitPage(
      {Key key, this.oid,this.index})
      : super(key: key);

  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final orders=Provider.of<Update>(context, listen: false);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 40,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                orders.updateOrderStatus(
                                      AppConfig.doneStatus, widget.index);
                                  APIServices.changeOrderStatus(
                                      widget.oid, AppConfig.doneStatus);
              });
               
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                    child: Text(
                  'Order Id',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                )),
              ),
              Container(
                  child: Text(
                    '#00'+
                widget.oid.toString(),
                style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6B6B6B)),
              )),
              SizedBox(
                height: 45,
              ),
              Container(
                  child: Text('Order Handover Successful',
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold))),
               Container(
                  child: AnimatedCheck(
                progress: _animation,
                size: 200,
                color: Colors.green,
              )),
            ],
          ),
        ),
      ),
    );
  }
}