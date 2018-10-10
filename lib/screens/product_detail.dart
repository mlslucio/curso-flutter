import 'package:flutter/material.dart';
import '../models/product.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/main.dart';

class ProductDetailScreen extends StatelessWidget {
  final int index;

  ProductDetailScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          //Navigator.pop(context, true);
          return Future.value(true);
        },
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child,
                    MainModel model) =>
                Scaffold(
                    appBar:
                        AppBar(title: Text(model.products[this.index].title)),
                    body: ListView(children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset(model.products[this.index].image),
                          Container(
                              child: Text(model.products[this.index].title),
                              padding: EdgeInsets.all(10.0)),
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
                                                model.deleteProduct(
                                                    model.products[this.index]);
                                                Navigator.pop(context);
                                                Navigator.pop(context, true);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text('Cancel'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )
                                          ],
                                        );
                                      });
                                }),
                            padding: EdgeInsets.all(10.0),
                          ),
                        ],
                      )
                    ]))));
  }
}
