import 'package:flutter/material.dart';
import '../product_manager.dart';
import 'product_admin.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
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
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
        title: Text('Easy List'),
      ),
      body: ProductManager(),
    );
  }
}
