import 'package:Seller_App/widgets/defaultButton.dart';
import 'package:flutter/material.dart';

//Screen shown when device is offline indicating to check the connection
class InternetError extends StatefulWidget {
  static String routeName = '/internetError';

  @override
  _InternetErrorState createState() => _InternetErrorState();
}

class _InternetErrorState extends State<InternetError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                  opacity: 0.64,
                  child: Icon(
                    Icons.wifi_off,
                    size: 32,
                  )),
              SizedBox(
                height: 20,
              ),
              Opacity(
                opacity: 0.64,
                child: Text(
                  'You are offline',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Opacity(
                opacity: 0.4,
                child: Text(
                  'It seems there is a problem with your connection.Please check your internet status.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )),
    );
  }
}
