import 'dart:io';

import 'package:flutter/material.dart';
import './additemform_screen.dart';
import './edititemform_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({Key? key}) : super(key: key);

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  int _selectedPageIndex = 0;
  double summary = 0.0;
  bool _isApiCallInProgress = false;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Map<String, dynamic>? quotationData;

  Future<Map<String, dynamic>> _fetchQuotation() async {
    //When updated from local host to IP address, able to see the output..later will replace with actual code
    final response =
        await http.get(Uri.parse('http://192.168.225.156:3000/quotation'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load quotation');
    }
  }

  //Below code is to display the dialog before completing
  Future<bool> _showDeleteConfirmationDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this entry?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    return confirmed ?? false;
  }

  List<DataRow> rows = [];

  double _calculateTotalPrice() {
    double sum = 0;
    for (var row in rows) {
      sum += double.parse(row.cells[3].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''));
    }
    return sum;
  }

  void _addItem() {
    if(_isApiCallInProgress){
      return;
    }
    setState(() {
      _isApiCallInProgress = true; // set this to true when the API call starts
    });

    DataRow? dataRow; // Declare the variable as nullable.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemForm(),
      ),
    ).then((newItem) {
      if (newItem != null) {
        setState(() {
          dataRow = DataRow(cells: [
            DataCell(Text(newItem['item'])),
            DataCell(Text(newItem['pricePerSft'])),
            DataCell(Text(newItem['quantity'])),
            DataCell(Text(newItem['totalPrice'])),
            DataCell(Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editItem(dataRow!);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await _showDeleteConfirmationDialog();
                    if (confirmed && dataRow != null) {
                      // Check if dataRow is not null.
                      setState(() {
                        rows.remove(dataRow);
                        summary -= double.parse(newItem['totalPrice']);
                      });
                    }
                  },
                ),
              ],
            )),
          ]);
          if (dataRow != null) {
            // Check if dataRow is not null.
            rows.add(dataRow!);
            summary += double.parse(newItem['totalPrice']);
          }
        });
      }

      setState(() {
        _isApiCallInProgress =
            false; // set this back to false when the API call completes
      });
    });
  }

  void _editItem(DataRow dataRow) {
    final currentValues = {
      'item': dataRow.cells[0].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
      'pricePerSft': dataRow.cells[1].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
      'quantity': dataRow.cells[2].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
      'totalPrice': dataRow.cells[3].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
    };

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EditItemForm(
          item: currentValues['item']!,
          pricePerSft: currentValues['pricePerSft']!,
          quantity: currentValues['quantity']!,
          totalPrice: currentValues['totalPrice']!,
        );
      },
    ).then((updatedValues) {
      if (updatedValues != null) {
        setState(() {
          dataRow.cells[0] = DataCell(Text(updatedValues['item']!));
          dataRow.cells[1] = DataCell(Text(updatedValues['pricePerSft']!));
          dataRow.cells[2] = DataCell(Text(updatedValues['quantity']!));
          dataRow.cells[3] = DataCell(Text(updatedValues['totalPrice']!));
        });
      }
    });
  }

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _fetchQuotation().asStream().listen((data) {
      setState(() {
        quotationData = data;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No records found"),
              SizedBox(height: 16),
              FloatingActionButton(
                onPressed: _addItem,
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 500,
          child: SingleChildScrollView(
            child:
                _isApiCallInProgress // display the CircularProgressIndicator widget only when the API call is being made
                    ? Center(child: CircularProgressIndicator())
                    : DataTable(
                        //column spacing will help you to provide space properly
                        dataRowHeight: 25,
                        columnSpacing: 25,
                        columns: [
                          DataColumn(label: Text('Item')),
                          DataColumn(label: Text('Price/Sft')),
                          DataColumn(label: Text('Quantity')),
                          DataColumn(label: Text('Total Price')),
                          DataColumn(
                            label: Text('Actions'),
                          ),
                        ],
                        rows: rows,
                      ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _addItem,
              child: Icon(Icons.add),
            ),
            SizedBox(height: 16),
            //Text("Total Quotation Amounts: $summary"),
            Text("Total Quotation Amounts: $quotationData"),
          ],
        ),
      );
    }
  }
}
