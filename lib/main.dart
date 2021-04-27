import 'package:flutter/material.dart';
import 'providers/orderUpdate.dart';
import 'providers/products.dart';
import 'providers/rejection.dart';
import 'root.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Session.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RejectionReasons>(
        create: (_) => RejectionReasons(),
      ),
      ChangeNotifierProvider<Product>(
        create: (_) => Product(),
      ),
      ChangeNotifierProvider<Update>(
        create: (_) => Update(),
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Colors.black
      ),
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
  String deviceToken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
   
    _firebaseMessaging.getToken().then((token) {
     // APIServices.updateSellerDevice(token);
      print("Device Token: $token");
    });
  }
  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text('New Order placed!!'),
              subtitle: Text('continue'),
            ),
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
    return MaterialApp(
      title: 'Image Loader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        accentColor: Color(0xff393E43),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 22.0, color: Colors.blueGrey),
          headline2: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.blueGrey,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
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
