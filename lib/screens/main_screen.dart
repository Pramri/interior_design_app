import 'package:flutter/material.dart';

import '../screens/tabs_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/filter_screen.dart';
import '../main.dart';
class MainPage extends StatelessWidget {
  final Function logout;

  MainPage({required this.logout});

  TextStyle titleTextStyle() {
    return TextStyle(
        fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold);
  }

  void _logout() {
    logout(); // Assuming that the function is defined as logout() in the imported file
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
          appBarTheme: AppBarTheme(titleTextStyle: titleTextStyle())),
          home: TabsScreen(logout: _logout),
      routes: {
        '/dashboard': (ctx) => DashboardScreen(),
        '/filter': (ctx) => FilterScreen(),
      },
    );
  }
}
