import 'package:flutter/material.dart';
import '../product_manager.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/product.dart';

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
          ScopedModelDescendant<ProductsModel>(
              builder: (context, child, model) => FlatButton(
                    child: Icon(model.favoriteStatus
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      model.toggleDisplayMode();
                    },
                  )),
        ],
        title: Text('Easy Lissst'),
      ),
      body: ProductManager(),
    );
  }
}
