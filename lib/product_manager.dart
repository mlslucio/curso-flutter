import 'package:flutter/material.dart';

import './products.dart';

class ProductManager extends StatefulWidget {
  final String _starterProduct;

  ProductManager(this._starterProduct);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  void initState() {
    this._products.add(widget._starterProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
          child: Text('Add Product'),
          onPressed: () {
            setState(() {
              _products.add('New Food Test');
            });
          },
        ),
      ),
      Products(_products)
    ]);
  }
}
