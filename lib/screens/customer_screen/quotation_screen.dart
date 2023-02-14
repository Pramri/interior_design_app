import 'dart:io';

import 'package:flutter/material.dart';
import './additemform_screen.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({Key? key}) : super(key: key);

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
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

void _removeEntry(DataRow selectedData) {
  int index = rows.indexOf(selectedData);
  setState(() {
    rows.removeAt(index);
  });
}

void _deleteEntry(DataRow selectedData) async {
  final confirmed = await _showDeleteConfirmationDialog();
  if (confirmed) {
    int index = rows.indexOf(selectedData);
    setState(() {
      rows.removeAt(index);
    });
  }
}

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
                    onPressed: () async {
                      final confirmed = await _showDeleteConfirmationDialog();
                      print("New item value"+newItem);
                      if (confirmed) {
                        rows.removeAt(newItem);
                      }
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
