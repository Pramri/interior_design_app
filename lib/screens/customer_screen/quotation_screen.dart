import 'dart:io';

import 'package:flutter/material.dart';
import './additemform_screen.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({Key? key}) : super(key: key);

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
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
                     print("here is the logic for edit button");
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                      rows.removeAt(1);
              });
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


  void generatePDF(List<DataRow> rows) async {
  final pdf = pdfWidgets.Document();

  pdf.addPage(
    pdfWidgets.MultiPage(
      build: (context) => [
        pdfWidgets.Table.fromTextArray(
          context: context,
          data: <List<String>>[
            <String>['Item', 'Price/Sft', 'Total Price'],
            ...rows.map((row) => [
              row.cells[0].child.toString(),
              row.cells[1].child.toString(),
              row.cells[2].child.toString(),
            ]),
          ],
        ),
      ],
    ),
  );

final file = File('quotation.pdf');
Uint8List pdfBytes = await pdf.save();
await file.writeAsBytes(pdfBytes);
}
}