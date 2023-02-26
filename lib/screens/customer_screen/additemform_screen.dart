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
  void initState() {
    super.initState();
    // add listener to Price/Sft and Quantity fields
    _pricePerSftController.addListener(_calculateTotalPrice);
    _quantityController.addListener(_calculateTotalPrice);
  }

  void _calculateTotalPrice() {
    // calculate Total Price based on Price/Sft and Quantity
    double pricePerSft = double.tryParse(_pricePerSftController.text) ?? 0;
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    double totalPrice = pricePerSft * quantity;
    // update Total Price field with the calculated value
    _totalPriceController.text = totalPrice.toStringAsFixed(2);
  }

  void _submitForm() async {

    if (mounted) {
        if (_formKey.currentState?.validate() ?? true) {
      // Build the request payload
      final payload = {
        'item': _itemController.text,
        'pricePerSft': _pricePerSftController.text,
        'quantity': _quantityController.text,
        'totalPrice': _totalPriceController.text,
      };

      // Call the API
      final response = await _callDummyApi(payload);

      // Store the response in a variable
      final result = response['result'];

      // Close the form and pass the result back to the previous screen
      Navigator.pop(context, result);
    }
      }

  }



  Future<Map<String, dynamic>> _callDummyApi(
      Map<String, dynamic> payload) async {
    // Simulate an API call by waiting for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    // Create a dummy response
    final result = {
      'status': 'success',
      'message': 'Item added successfully',
      'result': {
        'item': payload['item'],
        'pricePerSft': payload['pricePerSft'],
        'quantity': payload['quantity'],
        'totalPrice': payload['totalPrice'],
      },
    };
    return result;
  }

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
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pricePerSftController,
                decoration: InputDecoration(labelText: 'Price/Sft'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _totalPriceController,
                decoration: InputDecoration(labelText: 'Total Price'),
                enabled: false, // disable editing
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
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
