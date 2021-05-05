import 'package:flutter/material.dart';
import 'submittedScreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/providers/orderUpdate.dart';

class Verify extends StatelessWidget {
  final int oid;
  final int index;
  final String deliveryOTP;
  Verify({Key key, this.oid, this.index,this.deliveryOTP}) : super(key: key);
  var  otp;
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Update>(context, listen: false);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.grey[300],
        body: Builder(
          builder: (context) => Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      child: Text(
                    'DRIVER HANDOVER',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Text('Enter the OTP sent to the delivery resource',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w300))),
                  Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                    //padding: const EdgeInsets.all(10.0),
                    child: PinCodeTextField(
                      cursorColor: Colors.green[400],
                      boxShadows: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.4),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      appContext: context,
                      length: 6,
                      onChanged: (value) {},
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        inactiveColor: Colors.black,
                        activeColor: Colors.green,
                        selectedColor: Colors.green[200],
                      ),
                      onCompleted: (value) {
                        otp = value;
                      },
                    ),
                  ),
                  Container(
                      width: 160,
                      height: 43,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Color(0xff87BB40),
                        onPressed: () {
                          if (otp == null) {
                            showOTP(context);
                          } else if (otp == deliveryOTP) {
                            orders.completeOrders(index);
                            APIServices.changeOrderStatus(
                                oid, AppConfig.doneStatus);
                            showSnackBar(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubmitPage(
                                          oid: oid,
                                        )));
                          } else {
                            showError(context);
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 50.0,
        child: Center(
          child: Text(
            'OTP Verified Successfully',
            style: const TextStyle(fontSize: 22.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.white24,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showOTP(BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 50.0,
        child: Center(
          child: Text(
            'Please Enter the OTP',
            style: const TextStyle(fontSize: 22.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.white24,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showError(BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 50.0,
        child: Center(
          child: Text(
            'Sorry!! Wrong OTP Entered Try Again ',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.white24,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
