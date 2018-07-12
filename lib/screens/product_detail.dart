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
        Navigator.pop(context, true);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageUrl),
              Container(child: Text(title), padding: EdgeInsets.all(10.0)),
              Container(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Delete'),
                  onPressed: () => Navigator.pop(context, true),
                ),
                padding: EdgeInsets.all(10.0),
              ),
            ],
          ))),
    );
  }
}
