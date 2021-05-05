import 'package:flutter/material.dart';
import 'package:Seller_App/APIServices/APIServices.dart';
import 'package:Seller_App/providers/orderUpdate.dart';
import 'package:Seller_App/models/orders.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/models/rejectionReasons.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
enum SingingCharacter { reason1, reason2 ,reason3,reason4}
bool isVisible=false;

String reason="";
Future<void> showReasonsDialog(BuildContext context,int i,int oid) async {
  final orders = Provider.of<Update>(context, listen: false);
  return await showDialog(context: context,
      builder: (context){
        SingingCharacter  _character = SingingCharacter.reason1;
        final TextEditingController _textEditingController = TextEditingController();
        bool isChecked = false;
        isVisible=false;
        return StatefulBuilder(builder: (context,setState){
          return AlertDialog(
            contentPadding:EdgeInsets.only(left: 24,right: 24,top: 10,bottom: 0),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Select the rejection reason',style: TextStyle(fontSize: 20),),
            content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile<SingingCharacter>(
                          contentPadding: EdgeInsets.all(0),
                          title:  Text(reasons[0]),
                          value: SingingCharacter.reason1,
                          groupValue: _character,
                          onChanged: (value) {
                            setState(() {
                              isVisible=false;
                              _character = value;
                              reason=reasons[0];
                            });
                          },
                        ),
                        RadioListTile<SingingCharacter>(
                          contentPadding: EdgeInsets.all(0),
                          title:  Text(reasons[1]),
                          value: SingingCharacter.reason2,
                          groupValue: _character,
                          onChanged: (value) {
                            setState(() {
                              isVisible=false;
                              _character = value;
                              reason=reasons[1];
                            });
                          },
                        ),
                        RadioListTile<SingingCharacter>(
                          contentPadding: EdgeInsets.all(0),
                          title:  Text(reasons[2]),
                          value: SingingCharacter.reason3,
                          groupValue: _character,
                          onChanged: (value) {
                            setState(() {
                              isVisible=false;
                              _character = value;
                              reason=reasons[2];
                            });
                          },
                        ),
                        RadioListTile<SingingCharacter>(
                          contentPadding: EdgeInsets.all(0),
                          title:  Text(reasons[3]),
                          value: SingingCharacter.reason4,
                          groupValue: _character,
                          onChanged: (value) {
                            setState(() {
                              _character = value;
                              isVisible=true;
                            });
                          },
                        ),
                        Visibility(
                          visible: isVisible,
                          child: Padding(
                            padding: const EdgeInsets.only(left:40.0),
                            child: TextFormField(
                              controller: _textEditingController,
                              validator: (value){
                                return value.isNotEmpty ? null : "Enter the reason of rejection";
                              },
                              decoration: InputDecoration(hintText: " Reason"),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                )),
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
                  if(_formKey.currentState.validate()){
                    reason=_textEditingController.text;
                    print(reason);
                    orders.rejectOrder(i);
                    APIServices.addRejectionStatus(oid,
                        reason, AppConfig.rejectedStatus);
                    // Do something like updating SharedPreferences or User Settings etc.
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
      });
}
