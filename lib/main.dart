import 'package:flutter/material.dart';
import 'package:order_listing/providers/orderUpdate.dart';
import 'package:order_listing/providers/rejection.dart';
import 'package:order_listing/widgets/root.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'session.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Session.init();
  runApp(MultiProvider(
      providers: [
        
        ChangeNotifierProvider<RejectionReasons>(
        create: (_) => RejectionReasons(),),
        ChangeNotifierProvider<Update>(
        create: (_) => Update(),),
        
      ],
      child: MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  FirebaseMessaging _firebaseMessaging =FirebaseMessaging();
   _getToken() {
    _firebaseMessaging.getToken().then((token) {
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
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
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
        print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        Provider.of<Update>(context, listen: false).ordersAdded();
        print('onResume: $message');
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
    Provider.of<Update>(context, listen: false).ordersAdded();
    Provider.of<Update>(context, listen: false).fetchName();
    Provider.of<Update>(context, listen: false).fetchAvlb();
    _messages=List<Message>();
    _getToken();
    _configureFirebaseListeners();

    
  }
  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    print("Title: $title, body: $body, message: $mMessage");
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
            color: Colors.blueAccent,
          ),
        ),
      ),
      home: RootPage(),
    );
  }
}
class Message{
  String title;
  String body;
  String message;
  Message(title,body,message){
    this.title=title;
    this.body=body;
    this.message=message;
  }
}