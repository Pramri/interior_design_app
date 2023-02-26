import 'package:flutter/material.dart';

import '../screens/tabs_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/filter_screen.dart';
import 'package:firebase_core/firebase_core.dart';



class MainPage extends StatelessWidget {
  TextStyle titleTextStyle() {
    return TextStyle(
        fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold);
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
      //home: DashboardScreen(),
      routes: {
        '/': (ctx) => TabsScreen(),
        '/dashboard': (ctx) => DashboardScreen(),
        '/filter': (ctx) => FilterScreen(),
      },
    );
  }
}