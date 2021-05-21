import 'package:Seller_App/widgets/cards.dart';
import 'package:flutter/material.dart';

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({
    Key key,
    @required this.screenwidth,
  }) : super(key: key);

  final double screenwidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft:Radius.circular(30))),
      width: screenwidth*0.65,
      child: Drawer(
        child: Container(
          child: Column(
            children: [
              Row( 
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                                        child: IconButton(onPressed: (){
                                          Navigator.pop(context);
                                        },
                    icon: Icon(Icons.arrow_back),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text('Notifications',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Cards(
                  color:Color(0xffF1F5EF),
                  padding: EdgeInsets.all(0),
                  child:Container(
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.black26),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    width:200,
                    height:100
                  )
                ),
              )
            ],
          )),
      ),
    );
  }
}