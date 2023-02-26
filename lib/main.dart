import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:interior_design_app/screens/analytics_screen.dart';
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
  }

  void _logout() {
    print("entered.....");
    setState(() {
      _isLoggedIn = false;
    });
    print("exited.....");
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (context) =>
              LoginPage(redirectPage: '/mainpage', login: _login),
        );
      // Add more cases for additional routes as needed
      default:
        // If there is no such named route in the switch statement, throw an error
        throw Exception('Invalid route: ${settings.name}');
    }
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
      home: _isLoggedIn
          ? TabsScreen(logout: _logout)
          : LoginPage(redirectPage: '/test', login: _login),
      routes: {
        '/dashboard': (ctx) => DashboardScreen(),
        '/filter': (ctx) => FilterScreen(),
        '/mainpage': (ctx) => MainPage(logout: _logout),
        '/analytics': (ctx) => AnalyticsScreen(logout: _logout),
        '/test': (ctx)=> TabsScreen(logout: _logout),
      },
      onGenerateRoute: generateRoute,
    );
  }
}
