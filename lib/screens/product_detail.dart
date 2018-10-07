import 'package:flutter/material.dart';
import '../models/product.dart';
import 'dart:async';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final Function _deleteProduct;

  ProductDetailScreen(this.product, this._deleteProduct);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //Navigator.pop(context, true);
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(title: Text(product.title)),
          body: ListView(children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(product.image),
                Container(
                    child: Text(product.title), padding: EdgeInsets.all(10.0)),
                Container(
                  child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text('Delete'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text('alert body'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      this._deleteProduct(product);
                                      Navigator.pop(context);
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Cancel'),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              );
                            });
                      }),
                  padding: EdgeInsets.all(10.0),
                ),
              ],
            )
          ])),
    );
  }
}
