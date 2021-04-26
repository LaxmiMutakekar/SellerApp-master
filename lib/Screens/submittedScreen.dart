import 'package:flutter/material.dart';
import 'package:Seller_App/Home.dart';

class SubmitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                '#007',
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
                  child: Icon(
                Icons.check_sharp,
                size: 100,
                color: Color(0xff0CA437),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
