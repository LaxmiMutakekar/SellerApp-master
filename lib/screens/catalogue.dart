
  
import 'package:order_listing/session.dart';
import 'package:flutter/material.dart';
import 'package:order_listing/APIServices/APIServices.dart';
import 'package:order_listing/models/products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Catalogue extends StatefulWidget {
  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  bool vl = false;
  Future<List<dynamic>> _products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _products=APIServices.fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Catalogue",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FutureBuilder(
                  future: _products,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            Products item = snapshot.data[index];
                            //vl = item.available;
                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  'https://raw.githubusercontent.com/LaxmiMutakekar/SellerApp-master/master/assets/pizza.jpeg')),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                item.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              FlutterSwitch(
                                                width: 50.0,
                                                height: 25.0,
                                                valueFontSize: 13.0,
                                                toggleSize: 10.0,
                                                value: !vl,
                                                borderRadius: 30.0,
                                                padding: 6.0,
                                                showOnOff: true,
                                                onToggle: (val) {
                                                  print(item.pid.toString() +
                                                      vl.toString());
                                                  setState(() {
                                                    vl = val;
                                                    // APIService
                                                    //     .updateProdAvailable(
                                                    //         val,
                                                    //         value.token,
                                                    //         item.pid);
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          Text(
                                            item.skuId,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: 250,
                                            child: Text(
                                              item.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            item.price.toString(),
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ])),
                                  ),
                                ],
                              )),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      );
  }
}