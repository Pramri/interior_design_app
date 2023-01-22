import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

static const routeName = 'filter';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Filter'),
    );
  }
}