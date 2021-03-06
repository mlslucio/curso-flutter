import 'package:flutter/material.dart';

import 'product_create.dart';
import 'product_list.dart';
import '../scoped-model/main.dart';
import '../ui-elements/logout.dart';

class ProductAdminScreen extends StatelessWidget {

  ProductAdminScreen();

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
                          Navigator.pushReplacementNamed(context, '/home')),
                  ListTile(
                      title: Text('Auth'),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/auth')),
                        Divider(),
                    LogoutElement()
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
                ProductCreateScreen(),
                ProductListScreen(null, null)
              ],
            )));
  }
}
