import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClientVendorScreen extends StatefulWidget {
  const ClientVendorScreen({Key? key}) : super(key: key);

  @override
  State<ClientVendorScreen> createState() => _ClientVendorScreenState();
}

class _ClientVendorScreenState extends State<ClientVendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Vendors"),
    );
  }
}