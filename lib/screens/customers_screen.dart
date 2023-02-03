import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../model/customerdata.dart';
import '../tables/customer_table.dart';
import '../screens/subtab_screen.dart';
class CustomersScreen extends StatefulWidget {

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {

    final List<CustomerData> _customerTransaction = [
    CustomerData(
      id: 't1',
      name: 'Customer1',
      address: 'Sasaram',
      phone: 8971245370,
    ),
    CustomerData(
      id: 't2',
      name: 'Customer2',
      address: 'Kochas',
      phone: 8971245370,
    ),
  ];

  _startAddNewTransaction(){
    print("Prabhat Ranjan");
  }

   void _addNewTransaction(
    String cId, String cName, String cAddress, int cPhone) {
    final newTx = CustomerData(
      id: cId,
      name: cName,
      address: cAddress,
      phone: cPhone,
    );
    setState(() {
      _customerTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomerTable(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction()),
    );
  }
}