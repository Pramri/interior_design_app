import 'package:flutter/material.dart';
import '../screens/subtab_screen.dart';
import './customers_screen.dart';
import 'analytics_screen.dart';
import './dashboard_screen.dart';
import '../main.dart';

class TabsScreen extends StatefulWidget {
  final Function logout;

  TabsScreen({required this.logout});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  void _logout() {
    widget.logout();// Assuming that the function is defined as logout() in the imported file
  }


  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': DashboardScreen(), 'title': 'Dashboard'},
      {'page': CustomersScreen(), 'title': 'Customers'},
      {'page': AnalyticsScreen(logout: _logout), 'title': 'Analytics'},
      {'page': SubTabScreen(), 'title': 'Account'},
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
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
