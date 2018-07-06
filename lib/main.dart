import 'package:flutter/material.dart';

import './product_manager.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Easy List'),
            ),
            body: ProductManager('Default Product')));
  }
}
