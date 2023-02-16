import 'package:flutter/material.dart';
class AddItemForm extends StatefulWidget {
  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  final _itemController = TextEditingController();
  final _pricePerSftController = TextEditingController();
  final _quantityController = TextEditingController();
  final _totalPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _itemController,
                decoration: InputDecoration(labelText: 'Item'),
                validator: (value) {
                  if (value?.isEmpty??true) {
                    return 'Please enter a item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pricePerSftController,
                decoration: InputDecoration(labelText: 'Price/Sft'),
                validator: (value) {
                  if (value?.isEmpty??true) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
               TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value?.isEmpty??true) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _totalPriceController,
                decoration: InputDecoration(labelText: 'Total Price'),
                validator: (value) {
                  if (value?.isEmpty??true) {
                    return 'Please enter total price';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate()??true) {
                      Navigator.pop(
                        context,
                        {
                          'item': _itemController.text,
                          'pricePerSft': _pricePerSftController.text,
                          'quantity': _quantityController.text,
                          'totalPrice': _totalPriceController.text,
                        },
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
