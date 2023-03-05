import 'package:flutter/material.dart';
import 'analytics_screen.dart';
import './customer_screen/expense_screen.dart';
import './customer_screen/overview_screen.dart';
import './customer_screen/quotation_screen.dart';
import './customer_screen/vendor_screen.dart';


class SubTabScreen extends StatefulWidget {
  final List<Map<String, Object>> pages = [
    {'page': OverviewScreen(), 'title': 'Overview'},
    {'page': QuotationScreen(), 'title': 'Quotations'},
    {'page': ExpenseScreen(), 'title': 'Expenses'},
    {'page': ClientVendorScreen(), 'title': 'Vendors'},
  ];

  @override
  _SubTabScreenState createState() => _SubTabScreenState();
}

class _SubTabScreenState extends State<SubTabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.pages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[400],
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.purple,
              indicatorColor: Colors.black,
              
              tabs: widget.pages
                  .map((page) => Tab(text: page['title'] as String))
                  .toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.pages.map((page) => page['page'] as Widget).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
