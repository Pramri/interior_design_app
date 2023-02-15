import 'dart:io';

import 'package:flutter/material.dart';
import './additemform_screen.dart';
import './edititemform_screen.dart';
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
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
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
          }
        });
      }
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
      'totalPrice': dataRow.cells[2].child
          .toString()
          .replaceAll('Text("', '')
          .replaceAll('")', ''),
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemForm(
          item: currentValues['item']!,
          pricePerSft: currentValues['pricePerSft']!,
          totalPrice: currentValues['totalPrice']!,
        ),
      ),
    ).then((updatedValues) {
      if (updatedValues != null) {
        setState(() {
          dataRow.cells[0] = DataCell(Text(updatedValues['item']));
          dataRow.cells[1] = DataCell(Text(updatedValues['pricePerSft']));
          dataRow.cells[2] = DataCell(Text(updatedValues['totalPrice']));
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
