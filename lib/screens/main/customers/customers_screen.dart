import 'package:flutter/material.dart';
import 'add_customer_screen.dart';
import 'edit_customer_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  int _selectedPageIndex = 0;
  bool _isApiCallInProgress = false;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  List<dynamic>? customersData;

  Future<void> _fetchCustomers() async {
    setState(() {
      _isApiCallInProgress = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'http://192.168.0.100:3000/api/interiors/pDoS87aUANGcfFin8aWi/customers'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<DataRow> newRows = [];
        DataRow? dataRow;
        for (final customer in data) {
          dataRow = DataRow(cells: [
            DataCell(Text(customer['name'] ?? '')),
            DataCell(Text(customer['email'] ?? '')),
            DataCell(Text(customer['mobileNumber'] ?? '')),
            DataCell(Text(customer['address'] ?? '')),
            DataCell(Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editname(dataRow!);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final confirmed = await _showDeleteConfirmationDialog();
                    if (confirmed) {
                      setState(() {
                        newRows.remove(dataRow);
                      });
                    }
                  },
                ),
              ],
            )),
          ]);
          newRows.add(dataRow);
        }

        setState(() {
          customersData = data;
        });
        rows = newRows;
      } else {
        throw Exception('Failed to load customers');
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isApiCallInProgress = false;
      });
    }
  }


Future<http.Response> _createCustomers(String name, String email, String mobileNumber, String address) async {
  final apiUrl = Uri.parse('http://192.168.0.100:3000/api/interiors/pDoS87aUANGcfFin8aWi/customers');

  Map<String, dynamic> data = {
    'name': name,
    'email': email,
    'mobileNumber': mobileNumber,
    'address': address,
  };

  final response = await http.post(
    apiUrl,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  return response;
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

void _addname() {
  if (_isApiCallInProgress) {
    return;
  }
  setState(() {
    _isApiCallInProgress = true; // set this to true when the API call starts
  });

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddCustomerForm(),
    ),
  ).then((newname) {
    if (newname != null) {
      print("**************************");
      print(newname['name']);
      print(newname['email']);
      print(newname['mobileNumber']);
      print(newname['address']);
      print("**************************");
      DataRow? dataRow;
      _createCustomers(
              newname['name'], newname['email'], newname['mobileNumber'], newname['address'])
          .then((response) {
        if (response.statusCode == 200) {
          setState(() {
              dataRow = DataRow(cells: [
              DataCell(Text(newname['name'])),
              DataCell(Text(newname['email'])),
              DataCell(Text(newname['mobileNumber'])),
              DataCell(Text(newname['address'])),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editname(dataRow!);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final confirmed = await _showDeleteConfirmationDialog();
                      if (confirmed) {
                        setState(() {
                          rows.remove(dataRow);
                        });
                      }
                    },
                  ),
                ],
              )),
            ]);
            rows.add(dataRow!);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add customer'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }).whenComplete(() {
        setState(() {
          _isApiCallInProgress = false; // set this back to false when the API call completes
        });
      });
    } else {
      setState(() {
        _isApiCallInProgress = false; // set this back to false when the user cancels the form
      });
    }
  });
}


  void _editname(DataRow dataRow) {
    final currentValues = {
      'name': dataRow.cells[0].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
      'email': dataRow.cells[1].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
      'mobileNumber': dataRow.cells[2].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
      'address': dataRow.cells[3].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
    };

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EditCustomerForm(
          name: currentValues['name']!,
          email: currentValues['email']!,
          mobileNumber: currentValues['mobileNumber']!,
          address: currentValues['address']!,
        );
      },
    ).then((updatedValues) {
      if (updatedValues != null) {
        setState(() {
          dataRow.cells[0] = DataCell(Text(updatedValues['name']!));
          dataRow.cells[1] = DataCell(Text(updatedValues['email']!));
          dataRow.cells[2] = DataCell(Text(updatedValues['mobileNumber']!));
          dataRow.cells[3] = DataCell(Text(updatedValues['address']!));
        });
      }
    });
  }

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
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
                onPressed: _addname,
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
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Phone')),
                          DataColumn(label: Text('Address')),
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
              onPressed: _addname,
              child: Icon(Icons.add),
            ),
            SizedBox(height: 16),
          ],
        ),
      );
    }
  }
}
