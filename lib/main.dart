
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/main_screen.dart';
import './screens/tabs_screen.dart';
import './screens/dashboard_screen.dart';
import './screens/filter_screen.dart';
import './login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
    TextStyle titleTextStyle() {
    return TextStyle(
        fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  void _login() {
    setState(() {
      _isLoggedIn = true;
    });
    print("**********************************************");
    print(_isLoggedIn);
    print("**********************************************");
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      //Combination of color, style, fonts etcc...
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          errorColor: Colors.red,
          fontFamily: 'Open Sans',
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: _isLoggedIn ? MainPage() : LoginPage(redirectPage: '/mainpage', login: _login),

      routes: {
        '/dashboard': (ctx) => DashboardScreen(),
        '/filter': (ctx) => FilterScreen(),
        '/mainpage': (ctx) => MainPage(),
      },
    );
  }
}
