import 'package:flutter/material.dart';
import './product_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light, primarySwatch: Colors.green),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Easy List'),
            ),
            body: ProductManager()));
  }
}
