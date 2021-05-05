import 'package:Seller_App/providers/seller.dart';
import 'package:flutter/material.dart';
import 'providers/orderUpdate.dart';
import 'providers/products.dart';
import 'root.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'session.dart';
import 'APIServices/APIServices.dart';
import 'package:google_fonts/google_fonts.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Session.init();
  runApp(MultiProvider(
    providers: [

      ChangeNotifierProvider<Product>(
        create: (_) => Product(),
      ),
      ChangeNotifierProvider<Update>(
        create: (_) => Update(),
      ),
      ChangeNotifierProvider<SellerDetail>(
        create: (_) => SellerDetail(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seller App',
      home: MyHomePage(title: 'Seller App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String devicetoken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      devicetoken = token;
      APIServices.updateSellerDevice(devicetoken);
      print("Device Token: $token");
    });
  }

  _configureFirebaseListeners() {
//     Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
// fcmStream.listen((token) {
//   print(token);
// });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
                height: 40,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xFFFFFF),
                  borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                ),
                child: Text(
                  'New order received!!',
                  style: TextStyle(
                    letterSpacing: 1.1,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        print('onMessage: $message');
        Provider.of<Update>(context, listen: false).ordersAdded();
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        //print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        Provider.of<Update>(context, listen: false).ordersAdded();
        //print('onResume: $message');
        _setMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  List<Message> _messages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messages = List<Message>();
    _getToken();
    Provider.of<SellerDetail>(context, listen: false).fetchSeller();
    _configureFirebaseListeners();
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    setState(() {
      Message msg = Message(title, body, mMessage);
      _messages.add(msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    var darkTextThem = TextTheme(
      headline1: TextStyle(fontSize: 22.0, color: Colors.blueGrey),
      headline2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
      subtitle2: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        fontSize: 12.0,
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
      caption: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
    );
    var darkTheme = ThemeData(
        primaryColor: Colors.white,
        highlightColor: Colors.white,
        dividerColor: Colors.white,
        buttonColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          primary: Colors.white,
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(100, 20),
              elevation: 5,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
        ),
        scaffoldBackgroundColor: Colors.grey[300],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        accentColor: Color(0xff393E43),
        textTheme: darkTextThem);
    var theme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey[300],
      highlightColor: Colors.black,
      dividerColor: Colors.black12,
      buttonColor: Colors.black,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.black87,
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.bodyText1,
            fixedSize: Size(100, 20),
            elevation: 5,
            
            primary: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
      ),
      scaffoldBackgroundColor: Colors.grey[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      accentColor: Color(0xff393E43),
      textTheme: TextTheme(
        
        headline1: GoogleFonts.raleway(
            textStyle: TextStyle(fontSize: 28.0)),
        headline2: GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        )),
        headline6: GoogleFonts.raleway(
          textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        subtitle1: GoogleFonts.raleway(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        subtitle2: GoogleFonts.raleway(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        bodyText1: GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        )),
        bodyText2: GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        )),
        caption: GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        )),
        overline: 
        GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        button: 
        GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
      ),
      tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.all(0),
      
        unselectedLabelStyle:GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        )) ,
        labelStyle:GoogleFonts.raleway(
            textStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
      )
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      home: RootPage(),
    );
  }
}

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}
