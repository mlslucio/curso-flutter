import 'package:flutter/material.dart';
import '../product_manager.dart';
import 'dart:async';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductDetailScreen(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //Navigator.pop(context, true);
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: ListView(children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(this.imageUrl),
                Container(child: Text(title), padding: EdgeInsets.all(10.0)),
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
