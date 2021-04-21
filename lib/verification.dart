import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'submitPage.dart';

class Verify extends StatelessWidget {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back,size: 40,),onPressed: (){
            Navigator.pop(context);
          },),
        ),
        backgroundColor: Colors.grey[300],
        body: Center(
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
                  margin: const EdgeInsets.only(left: 70.0, right: 70),
                  padding: const EdgeInsets.all(20.0),
                  child: PinPut(
                    fieldsCount: 4,
                    onSubmit: (String pin) => _showSnackBar(pin, context),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey[300].withOpacity(.5),
                      ),
                    ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SubmitPage()),
                        );
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
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.black12,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
