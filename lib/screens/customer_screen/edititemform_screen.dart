import 'package:flutter/material.dart';

class EditItemForm extends StatefulWidget {
  final String item;
  final String pricePerSft;
  final String totalPrice;

  const EditItemForm({
    Key? key,
    required this.item,
    required this.pricePerSft,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  late final TextEditingController _itemController;
  late final TextEditingController _pricePerSftController;
  late final TextEditingController _totalPriceController;

  @override
  void initState() {
    super.initState();
    _itemController = TextEditingController(text: widget.item);
    _pricePerSftController = TextEditingController(text: widget.pricePerSft);
    _totalPriceController = TextEditingController(text: widget.totalPrice);
  }

  @override
  void dispose() {
    _itemController.dispose();
    _pricePerSftController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: 'Item',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _pricePerSftController,
              decoration: InputDecoration(
                labelText: 'Price per square foot',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _totalPriceController,
              decoration: InputDecoration(
                labelText: 'Total Price',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'item': _itemController.text,
                  'pricePerSft': _pricePerSftController.text,
                  'totalPrice': _totalPriceController.text,
                });
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
