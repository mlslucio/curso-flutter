import 'package:flutter/material.dart';

import 'product_create.dart';
import 'product_list.dart';

class ProductAdminScreen extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;
  final List<Map<String, dynamic>> products;

  ProductAdminScreen(this.addProduct, this.deleteProduct, this.products);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            drawer: Drawer(
              child: Column(
                children: <Widget>[
                  AppBar(
                    automaticallyImplyLeading: false,
                    title: Text('Choose'),
                  ),
                  ListTile(
                      title: Text('All Products'),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/')),
                  ListTile(
                      title: Text('Auth'),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/auth'))
                ],
              ),
            ),
            appBar: AppBar(
              title: Text('Manage Products'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.create), text: 'Create Product'),
                  Tab(
                    icon: Icon(Icons.list),
                    text: 'My Products',
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                ProductCreateScreen(addProduct),
                ProductListScreen(products)
              ],
            )));
  }
}
