import 'package:flutter/material.dart';
import './customer_screen/additemform_screen.dart';
import 'package:http/http.dart' as http;

class CustomersScreen extends StatefulWidget {
  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<DataRow> rows = [
    DataRow(cells: [
      DataCell(Text('item1')),
      DataCell(Text('20')),
      DataCell(Text('200')),
      DataCell(Row(
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit action
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Handle delete action
            },
          ),
        ],
      )),
    ]),
    DataRow(cells: [
      DataCell(Text('item2')),
      DataCell(Text('20')),
      DataCell(Text('200')),
      DataCell(Row(
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit action
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Handle delete action
            },
          ),
        ],
      )),
    ]),
  ];


  final _itemController = TextEditingController();
  final _pricePerSftController = TextEditingController();
  final _totalPriceController = TextEditingController();

  bool _isAddFormVisible = false;

  void _addItem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemForm(),
      ),
    ).then((newItem) {
      if (newItem != null) {
        setState(() {
          rows.add(
            DataRow(cells: [
              DataCell(Text(newItem['item'])),
              DataCell(Text(newItem['pricePerSft'])),
              DataCell(Text(newItem['totalPrice'])),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Handle edit action
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle delete action
                    },
                  ),
                ],
              )),
            ]),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataTable(
        columns: [
          DataColumn(label: Text('Item')),
          DataColumn(label: Text('Price/Sft')),
          DataColumn(label: Text('Total Price')),
          DataColumn(label: Text('Actions')),
        ],
        rows: rows,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
