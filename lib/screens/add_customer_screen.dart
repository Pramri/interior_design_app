import 'package:flutter/material.dart';

class AddCustomerForm extends StatefulWidget {
  @override
  _AddCustomerFormState createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
  }

  void _submitForm() async {

    if (mounted) {
        if (_formKey.currentState?.validate() ?? true) {
      final payload = {
        'name': _nameController.text,
        'email': _emailController.text,
        'mobileNumber': _phoneController.text,
        'address': _addressController.text,
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
      'message': 'Name added successfully',
      'result': {
        'name': payload['name'],
        'email': payload['email'],
        'mobileNumber': payload['mobileNumber'],
        'address': payload['address'],
      },
    };
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Name'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a name name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a mobileNumber';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                // disable editing
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
