import 'package:flutter/material.dart';

class EditItemForm extends StatefulWidget {
  final String item;
  final String pricePerSft;
  final String quantity;
  final String totalPrice;

  const EditItemForm({
    Key? key,
    required this.item,
    required this.pricePerSft,
    required this.quantity,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  late final TextEditingController _itemController;
  late final TextEditingController _pricePerSftController;
  late final TextEditingController _quantityController;
  late final TextEditingController _totalPriceController;

  @override
  void initState() {
    super.initState();
    _itemController = TextEditingController(text: widget.item);
    _pricePerSftController = TextEditingController(text: widget.pricePerSft);
    _quantityController = TextEditingController(text: widget.quantity);
    _totalPriceController = TextEditingController(text: widget.totalPrice);

    // add listeners to price per sft and quantity fields
    _pricePerSftController.addListener(_updateTotalPrice);
    _quantityController.addListener(_updateTotalPrice);
  }

  @override
  void dispose() {
    _itemController.dispose();
    _pricePerSftController.removeListener(_updateTotalPrice);
    _pricePerSftController.dispose();
    _quantityController.removeListener(_updateTotalPrice);
    _quantityController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  void _updateTotalPrice() {
    final pricePerSft = double.tryParse(_pricePerSftController.text) ?? 0;
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final totalPrice = pricePerSft * quantity;
    _totalPriceController.text = totalPrice.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
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
            SizedBox(height: 12),
            TextField(
              controller: _pricePerSftController,
              decoration: InputDecoration(
                labelText: 'Price per square foot',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'quantity',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _totalPriceController,
              decoration: InputDecoration(
                labelText: 'Total Price',
                border: OutlineInputBorder(),
              ),
              enabled: false,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'item': _itemController.text,
                  'pricePerSft': _pricePerSftController.text,
                  'quantity': _quantityController.text,
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
