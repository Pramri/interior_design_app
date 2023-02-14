import 'package:flutter/material.dart';
import 'package:interior_design_app/screens/subtab_screen.dart';
import '../widgets/main_drawer.dart';
import './customers_screen.dart';
import 'analytics_screen.dart';
import './dashboard_screen.dart';
import './account_screen.dart';

class TabsScreen extends StatefulWidget {
 

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  
  final List<Map<String, Object>> _pages = [
    {'page': DashboardScreen(), 'title':'Dashboard'},
    {'page': CustomersScreen(), 'title':'Customers'},
    {'page': AnalyticsScreen(), 'title':'Analytics'},
    {'page': SubTabScreen(), 'title':'Account'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex=index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'].toString()),
      ),
      // drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        //backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.purple,
        selectedItemColor: Theme.of(context).colorScheme.secondary,

        currentIndex: _selectedPageIndex,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
             //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.group),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
           BottomNavigationBarItem(
             //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
