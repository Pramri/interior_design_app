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
  List<DataRow> rows = [];
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

        DataRow? dataRow;
        for (final customer in data) {
          dataRow = DataRow(cells: [
            DataCell(Text(customer['name'] ?? '')),
            DataCell(Text(customer['email'] ?? '')),
            DataCell(Text(customer['mobileNumber'] ?? '')),
            DataCell(Text(customer['address'] ?? '')),
            DataCell(PopupMenuButton(
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  child: Text("Edit"),
                  onTap: () {
                    _editname(customer);
                  },
                ),
                PopupMenuItem(
                  child: Text("Delete"),
                  onTap: () async {
                    final confirmed = await _showDeleteConfirmationDialog();
                    if (confirmed) {
                      print("Deleted");
                    }
                  },
                ),
              ],
            )),
          ]);
          rows.add(dataRow);
        }

        setState(() {
          customersData = data;
          rows = rows;
        });
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

  DataColumn actionColumn = DataColumn(
    label: Text('Action'),
  );

  Future<http.Response> _createCustomers(
      String name, String email, String mobileNumber, String address) async {
    final apiUrl = Uri.parse(
        'http://192.168.0.100:3000/api/interiors/pDoS87aUANGcfFin8aWi/customers');

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

  Future<http.Response> _updateCustomer(String customerId, String name,
      String email, String mobileNumber, String address) async {

    final apiUrl = Uri.parse(
        'http://localhost:3000/api/interiors/pDoS87aUANGcfFin8aWi/customers/3LIaY1ahi2LwhBJezgyt');
        print(apiUrl);
        print("**********************************");
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'address': address,
    };

    final response = await http.put(
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

  //List<DataRow> rows = [];

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
        DataRow? dataRow;
        _createCustomers(newname['name'], newname['email'],
                newname['mobileNumber'], newname['address'])
            .then((response) {
          if (response.statusCode == 200) {
            setState(() {
              dataRow = DataRow(cells: [
                DataCell(Text(newname['name'])),
                DataCell(Text(newname['email'])),
                DataCell(Text(newname['mobileNumber'])),
                DataCell(Text(newname['address'])),
                DataCell(PopupMenuButton(
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  child: Text("Edit"),
                  onTap: () {
                    // _editname("Test");
                    print("Hi");
                  },
                ),
                PopupMenuItem(
                  child: Text("Delete"),
                  onTap: () async {
                    final confirmed = await _showDeleteConfirmationDialog();
                    if (confirmed) {
                      print("Deleted");
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
            _isApiCallInProgress =
                false; // set this back to false when the API call completes
          });
        });
      } else {
        setState(() {
          _isApiCallInProgress =
              false; // set this back to false when the user cancels the form
        });
      }
    });
  }

void _editname(dynamic customer) {
  if (_isApiCallInProgress) {
    return;
  }
  setState(() {
    _isApiCallInProgress = true; // set this to true when the API call starts
  });
  print(customer);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditCustomerForm(customer: customer),
    ),
  ).then((editedCustomer) {
    if (editedCustomer != null) {
      print(editedCustomer);
      _updateCustomer(
              customer['id'],
              editedCustomer['name'],
              editedCustomer['email'],
              editedCustomer['mobileNumber'],
              editedCustomer['address'])
          .then((response) {
        if (response.statusCode == 200) {
          setState(() {
            final int index = customersData!
                .indexWhere((element) => element['id'] == customer['id']);
            customersData![index] = editedCustomer;
            rows[index] = DataRow(cells: [
              DataCell(Text(editedCustomer['name'] ?? '')),
              DataCell(Text(editedCustomer['email'] ?? '')),
              DataCell(Text(editedCustomer['mobileNumber'] ?? '')),
              DataCell(Text(editedCustomer['address'] ?? '')),
              DataCell(PopupMenuButton(
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    child: Text("Edit"),
                    onTap: () {
                      _editname(editedCustomer);
                    },
                  ),
                  PopupMenuItem(
                    child: Text("Delete"),
                    onTap: () async {
                      final confirmed =
                          await _showDeleteConfirmationDialog();
                      if (confirmed) {
                        print("Deleted");
                      }
                    },
                  ),
                ],
              )),
            ]);
          });
        }
        setState(() {
          _isApiCallInProgress = false; // set this to false when the API call ends
        });
      });
    } else {
      setState(() {
        _isApiCallInProgress = false; // set this to false when the API call ends
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
          child: SingleChildScrollView(
            child:
                _isApiCallInProgress // display the CircularProgressIndicator widget only when the API call is being made
                    ? Center(child: CircularProgressIndicator())
                    : DataTable(
                       dataRowHeight: 50,
                        columnSpacing: 2,
                        columns: [
                          DataColumn(
                              label: Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
                          )),
                          DataColumn(
                              label: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
                          )),
                          DataColumn(
                              label: Text(
                            'Phone',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
                          )),
                          DataColumn(
                              label: Text(
                            'Address',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
                          )),
                          DataColumn(
                              label: Text(
                            'Actions',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
                          )),
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
