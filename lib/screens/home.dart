import 'package:flutter/material.dart';
import '../product_manager.dart';
import 'product_admin.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _products;

  HomeScreen(this._products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
                leading: Icon(Icons.edit),
                title: Text('Manage Products'),
                onTap: () => Navigator.pushReplacementNamed(context, '/admin'))
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Easy List'),
      ),
      body: ProductManager(this._products),
    );
  }
}
