import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../screens/subtab_screen.dart';
class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

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
      //home: DashboardScreen(),
      routes: {
        '/' : (ctx) => SubTabScreen(),
      },
    );
  }
}