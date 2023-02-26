import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  final Function logout;

  AnalyticsScreen({required this.logout});

  @override
  Widget build(BuildContext context) {
   return 
      //Combination of color, style, fonts etcc...
        Center(
          child: ElevatedButton(
            child: Text('Logout'),
            onPressed: () {
              logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
    );
  }
}
