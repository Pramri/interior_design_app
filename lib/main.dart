import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interior_design_app/screens/subtab_screen.dart';
import './screens/tabs_screen.dart';
import './widgets/new_transaction.dart';
import './model/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './screens/dashboard_screen.dart';
import './screens/filter_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  TextStyle titleTextStyle (){
     return TextStyle(fontFamily: 'OpenSans',fontSize: 20, fontWeight: FontWeight.bold);
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
              titleTextStyle: titleTextStyle())),
      //home: DashboardScreen(),
      routes: {
        '/' : (ctx) => TabsScreen(),
        '/dashboard': (ctx) => DashboardScreen(),
        '/filter': (ctx) => FilterScreen(),
        
      },
    );
  }
}