import 'package:flutter/material.dart';
import './customers_screen.dart';
import './vendors_screen.dart';
import './dashboard_screen.dart';
class SubTabScreen extends StatefulWidget {
  const SubTabScreen({super.key});

  @override
  State<SubTabScreen> createState() => _SubTabScreenState();
}

class _SubTabScreenState extends State<SubTabScreen> {
  @override
  Widget build(BuildContext context) {
    //Used for bottom tabs.. so wrap Scaffold to DefaultTabcontroller
    return  DefaultTabController(length: 3, child: Scaffold(
        appBar: AppBar(
          title: Text('Pramri'),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.dashboard),
              text: 'Dashboard',
            ),
            Tab(
              icon: Icon(Icons.verified_user,),
              text: 'Customers',
            ),
            Tab(
              icon: Icon(Icons.verified_user,),
              text: 'Vendors',
            ),
          ]),
        ),
        body: TabBarView(children: [
          DashboardScreen(),
          CustomersScreen(),
          VendorsScreen(),
        ]),
    ),
    );
  }
}
