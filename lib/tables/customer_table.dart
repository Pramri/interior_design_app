import 'package:flutter/material.dart';
import '../model/customerdata.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Id',
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Name',
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Address',
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Phone No',
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('Prabhat')),
              DataCell(Text('Sasaram')),
              DataCell(Text('8971245370')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('2')),
              DataCell(Text('Ranjan')),
              DataCell(Text('Hyderabad')),
              DataCell(Text('8971245370')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('3')),
              DataCell(Text('Joe')),
              DataCell(Text('Uk')),
              DataCell(Text('8971245370')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('4')),
              DataCell(Text('John')),
              DataCell(Text('Bangalore')),
              DataCell(Text('8971245370')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('5')),
              DataCell(Text('Mohan')),
              DataCell(Text('Kochas')),
              DataCell(Text('8971245370')),
            ],
          ),
        ],
      ),
    );
  }
}
