import 'package:flutter/material.dart';

class SubTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
   late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedTabBarView(
        tabController: _tabController,
        mainTabIndex: _tabController.index,
      ),
      // bottomNavigationBar: Material(
      //   color: Colors.purple,
      //   child: TabBar(
      //     controller: _tabController,
      //     tabs: [
      //       Tab(text: 'Tab 1'),
      //       Tab(text: 'Tab 2'),
      //       Tab(text: 'Tab 3'),
      //     ],
      //   ),
      // ),
    );
  }
}

class NestedTabBarView extends StatefulWidget {
  final TabController tabController;
  final int mainTabIndex;
  NestedTabBarView({ Key? key, required this.tabController, required this.mainTabIndex}) : super(key: key);


  @override
  _NestedTabBarViewState createState() => _NestedTabBarViewState();
}

class _NestedTabBarViewState extends State<NestedTabBarView>
    with SingleTickerProviderStateMixin {
  late TabController _subTabController;

  @override
  void initState() {
    super.initState();
    _subTabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _subTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Hi");
    print(widget.mainTabIndex);
    print("hello");
    return widget.mainTabIndex==0 ? Column(
      children: [
        Container(
          color: Colors.purple,
          child: TabBar(
            controller: _subTabController,
            tabs: [
              Tab(text: 'Subtab 1'),
              Tab(text: 'Subtab 2'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _subTabController,
            children: [
              Center(
                child: Text('Subtab 1 content'),
              ),
              Center(
                child: Text('Subtab 2 content'),
              ),
            ],
          ),
        ),
      ],
    ):Container();
  }
}