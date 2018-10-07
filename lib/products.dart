import 'package:flutter/material.dart';
import 'package:curso_flutter/scoped-model/product.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/product.dart';

class Products extends StatelessWidget {
  Widget _buildProductItem(List<Product> products) {
    Widget lista = ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          createList(products[index], context, index),
      itemCount: products.length,
    );

    return lista;
  }

  createList(Product product, BuildContext context, index) {
    return Card(
        child: Column(children: <Widget>[
      Image.asset(product.image),
      Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            product.title,
            style: TextStyle(fontFamily: 'Oswald', fontSize: 24.0),
          ),
          SizedBox(width: 10.0),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text(
                'brl' + product.price.toString(),
                style: TextStyle(color: Colors.white),
              )),
        ],
      )),
      ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/product/' + index.toString()),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: Theme.of(context).primaryColor,
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/product/' + index.toString()),
          )
        ],
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products;
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return _buildProductItem(model.products);
    });
  }
}
