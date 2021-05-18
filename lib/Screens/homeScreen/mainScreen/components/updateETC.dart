import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:provider/provider.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
enum SingingCharacter { timing1, timing2 ,timing3,timing4}
final List<String> reasons = [
  '5 minutes',
  '10 minutes',
  '15 minutes',
  '30 minutes',
];
double duration=0;
Future<dynamic> updateETC(BuildContext context) async {
  //final orders = Provider.of<Update>(context, listen: false);
  return  showDialog(context: context,
      builder: (context){
        SingingCharacter  _character = SingingCharacter.timing1;
        return StatefulBuilder(builder: (context,setState){
          return AlertDialog(
            contentPadding:EdgeInsets.only(left: 24,right: 24,top: 10,bottom: 0),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Select the updating timing',style: TextStyle(fontSize: 20),),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<SingingCharacter>(
                      contentPadding: EdgeInsets.all(0),
                      title:  Text(reasons[0]),
                      value: SingingCharacter.timing1,
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          duration=5;
                          _character = value;
                        });
                      },
                    ),
                    RadioListTile<SingingCharacter>(
                      contentPadding: EdgeInsets.all(0),
                      title:  Text(reasons[1]),
                      value: SingingCharacter.timing2,
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          _character = value;
                          duration=10;
                        });
                      },
                    ),
                    RadioListTile<SingingCharacter>(
                      contentPadding: EdgeInsets.all(0),
                      title:  Text(reasons[2]),
                      value: SingingCharacter.timing3,
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          _character = value;
                          duration=15;
                        });
                      },
                    ),
                    RadioListTile<SingingCharacter>(
                      contentPadding: EdgeInsets.all(0),
                      title:  Text(reasons[3]),
                      value: SingingCharacter.timing4,
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          duration=30;
                          _character = value;

                        });
                      },
                    ),
                    

                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: (){

                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Continue'),
                onPressed: (){
                 // orders.updateETC(i,duration);
                  Navigator.of(context).pop(duration);

                },
              ),
            ],
          );
        });
      });
}
