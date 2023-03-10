import 'package:flutter/material.dart';

class EditCustomerForm extends StatefulWidget {
  final Map<String, dynamic> customer;

  const EditCustomerForm({Key? key, required this.customer}) : super(key: key);

  @override
  _EditCustomerFormState createState() => _EditCustomerFormState();
}

class _EditCustomerFormState extends State<EditCustomerForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer['name']);
    _emailController = TextEditingController(text: widget.customer['email']);
    _phoneController =
        TextEditingController(text: widget.customer['mobileNumber']);
    _addressController =
        TextEditingController(text: widget.customer['address']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
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
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'name': _nameController.text,
                  'email': _emailController.text,
                  'mobileNumber': _phoneController.text,
                  'address': _addressController.text,
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
